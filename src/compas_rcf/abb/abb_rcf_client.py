"""Procedures for pick and place operations on ABB robot arms."""
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import logging
import time

from compas.geometry import Frame
from compas.geometry import Translation
from compas_rrc import AbbClient
from compas_rrc import FeedbackLevel
from compas_rrc import MoveToFrame
from compas_rrc import MoveToJoints
from compas_rrc import Noop
from compas_rrc import PrintText
from compas_rrc import ReadWatch
from compas_rrc import SetAcceleration
from compas_rrc import SetDigital
from compas_rrc import SetMaxSpeed
from compas_rrc import SetTool
from compas_rrc import SetWorkObject
from compas_rrc import StartWatch
from compas_rrc import StopWatch
from compas_rrc import TimeoutException
from compas_rrc import WaitTime

from compas_rcf.docker import restart_container
from compas_rcf.robots import FRAME_LIST_TRAJECTORY_TYPE
from compas_rcf.robots import JOINT_TRAJECTORY_TYPE
from compas_rcf.robots import get_trajectory_type
from compas_rcf.robots import joint_trajectory_to_robot_joints_list

log = logging.getLogger(__name__)


class AbbRcfClient(AbbClient):
    DOCKER_IMAGE = "abb-driver"
    # Define external axis, will not be used but required in move cmds
    EXTERNAL_AXIS_DUMMY: list = []
    # Used to filter rob_joints if they are the same as the previous
    LAST_ROB_JOINTS = None

    def __init__(self, ros, rob_conf):
        super().__init__(ros)

        self.pick_place_tool = rob_conf.tools.get("pick_place")
        self.dist_sensor_tool = rob_conf.tools.get("dist_sensor")

        self.wobjs = rob_conf.wobjs

        self.global_speed_accel = rob_conf.robot_movement.global_speed_accel

        self.set_joint_pos = rob_conf.robot_movement.set_joint_pos

        self.speed = rob_conf.robot_movement.speed
        self.zone = rob_conf.robot_movement.zone

        self.docker_cfg = rob_conf.docker

        self.use_dist_sensor = self.dist_sensor_tool.serial_port is not None

    def ping(self, timeout=10):
        """Ping ABB robot controller.

        Parameters
        ----------
        client : :class:`compas_rrc.AbbClient`
            Client connected to controller.
        timeout : :class:`float`, optional
            Timeout for reply. Defaults to ``10``.

        Raises
        ------
        :exc:`TimeoutError`
            If no reply is returned before timeout.
        """
        self.send_and_wait(Noop(feedback_level=FeedbackLevel.DONE), timeout=timeout)

    def check_reconnect(self, timeout_ping=5, wait_after_up=2, tries=3):
        """Check connection to ABB controller and restart abb-driver if necessary.

        Parameters
        ----------
        client : :class:`compas_rrc.AbbClient`
            Client connected to controller.
        timeout_ping : :class:`float`, optional
            Timeout for ping response.
        wait_after_up : :class:`float`, optional
            Time to wait to ping after `abb-driver` container started.

        Raises
        ------
        :exc:`TimeoutError`
            If no reply is returned before timeout.
        """
        for _ in range(tries):
            try:
                log.debug("Pinging robot")
                self.ping(self.docker_cfg.timeout_ping)
                log.debug("Breaking loop after successful ping.")
                break
            except TimeoutException:
                log.info("No response from controller, restarting abb-driver service.")
                restart_container(self.DOCKER_IMAGE)
                time.sleep(self.docker_cfg.sleep_after_up)
        else:
            raise TimeoutException("Failed to connect to robot.")

    def pre_procedure(self):
        """Pre fabrication setup, speed, acceleration, tool, work object and initial pose.

        Uses ``fab_conf`` set up using
        :func:`compas_rcf.fab_data.interactive_conf_setup` for fabrication settings.

        Parameters
        ----------
        client : :class:`compas_rrc.AbbClient`
            Client connected to controller procedure should be sent to.
        """
        # for safety
        self.retract_needles()

        self.send(SetTool(self.pick_place_tool.name))
        log.debug("Tool {} set.".format(self.pick_place_tool.name))
        self.send(SetWorkObject(self.wobjs.place))
        log.debug("Work object {} set.".format(self.wobjs.place))

        # Set Acceleration
        self.send(
            SetAcceleration(
                self.global_speed_accel.accel, self.global_speed_accel.accel_ramp
            )
        )
        log.debug("Acceleration values set.")

        # Set Max Speed
        self.send(
            SetMaxSpeed(
                self.global_speed_accel.speed_override,
                self.global_speed_accel.speed_max_tcp,
            )
        )
        log.debug("Speed set.")

        # Initial configuration
        self.send(
            MoveToJoints(
                self.set_joint_pos.start,
                self.EXTERNAL_AXIS_DUMMY,
                self.speed.travel,
                self.zone.travel,
            )
        )
        log.debug("Sent move to safe joint position")

    def post_procedure(self):
        """Post fabrication procedure, end pose and closing and termination of client.

        Uses ``fab_conf`` set up using
        :func:`compas_rcf.fab_data.interactive_conf_setup` for fabrication settings.

        Parameters
        ----------
        client : :class:`compas_rrc.AbbClient`
        """
        self.retract_needles()

        self.send(
            MoveToJoints(
                self.set_joint_pos.end,
                self.EXTERNAL_AXIS_DUMMY,
                self.speed.travel,
                self.zone.travel,
            )
        )

        self.send_and_wait(PrintText("Finished"))

    def measure_cylinder(self, cylinder):

        port = self.dist_sensor_tool.serial_port
        baudrate = self.dist_sensor_tool.serial_baudrate

        self.send(SetTool(self.dist_sensor_tool.name))
        self.send(SetWorkObject(self.wobjs.pick))

        for measurement in cylinder.measurements:
            trajectory = [Frame.from_data(measurement.frame)]
            log.debug("frame")
            self.execute_trajectory(
                trajectory, self.speed.precise, self.zone.precise, blocking=True,
            )

            if not self.use_dist_sensor:
                log.info(
                    "Using dummy value for measurement since no distance sensor port is specified."  # noqa: E501
                )

            measurement.measure(port, baudrate, use_dummy=not self.use_dist_sensor)
            log.debug("Measurement: {}".format(measurement))

    def pick_bullet(self, cylinder):
        """Send movement and IO instructions to pick up a clay cylinder.

        Uses `fab_conf` set up with command line arguments and configuration
        file.

        Parameters
        ----------
        client : :class:`compas_rrc.AbbClient`
        picking_frame : :class:`compas.geometry.Frame`
            Target frame to pick up cylinder
        """
        # change work object before picking
        self.send(SetTool(self.pick_place_tool.name))
        self.send(SetWorkObject(self.wobjs.pick))

        # start watch
        self.send(StartWatch())

        self.send(
            MoveToFrame(
                cylinder.get_egress_frame(), self.speed.travel, self.zone.travel
            )
        )

        self.send(
            MoveToFrame(
                cylinder.get_uncompressed_top_frame(),
                self.speed.travel,
                self.zone.precise,
            )
        )

        self.send(WaitTime(self.pick_place_tool.needles_pause))
        self.extend_needles()
        self.send(WaitTime(self.pick_place_tool.needles_pause))

        self.send(
            MoveToFrame(
                cylinder.get_egress_frame(), self.speed.precise, self.zone.travel
            )
        )

        self.send(StopWatch())

        return self.send(ReadWatch())

    def execute_trajectory(self, trajectory, speed, zone, blocking=False):
        log.debug(f"Trajectory: {trajectory}")

        trajectory_type = get_trajectory_type(trajectory)

        if trajectory_type == JOINT_TRAJECTORY_TYPE:
            log.debug("Identified type: JointTrajectory")
            # Change zone precise to absj precise
            # TODO: Make this make sense
            if zone == self.zone.precise:
                zone = self.zone.absj_precise

            execute_func = self._execute_joint_trajectory

        elif trajectory_type == FRAME_LIST_TRAJECTORY_TYPE:
            log.debug("Identified type: Frame list")
            execute_func = self._execute_frame_trajectory

        else:
            raise ValueError(f"No trajectory execution function for {trajectory}.")

        execute_func(trajectory, speed, zone, blocking=blocking)

    def _execute_joint_trajectory(self, trajectory, speed, zone, blocking=False):
        robot_joints_list = joint_trajectory_to_robot_joints_list(trajectory)

        for i, rob_joints in enumerate(robot_joints_list):

            # test to see if sending same conf twice causes corner error
            if rob_joints == self.LAST_ROB_JOINTS:
                continue

            cmd = MoveToJoints(rob_joints, self.EXTERNAL_AXIS_DUMMY, speed, zone)

            if blocking and i == len(robot_joints_list) - 1:
                self.send_and_wait(cmd)
            else:
                self.send(cmd)

            self.LAST_ROB_JOINTS = rob_joints

    def _execute_frame_trajectory(self, trajectory, speed, zone, blocking=False):
        for i, frame in enumerate(trajectory):
            cmd = MoveToFrame(frame, speed, zone)
            if blocking and i == len(trajectory) - 1:
                self.send_and_wait(cmd)
            else:
                self.send(cmd)

    def place_bullet(self, cylinder):
        """Send movement and IO instructions to place a clay cylinder.

        Uses `fab_conf` set up with command line arguments and configuration
        file.

        Parameters
        ----------
        client : :class:`compas_rrc.AbbClient`
            Client connected to controller procedure should be sent to.
        cylinder : :class:`compas_rcf.fab_data.ClayBullet`
            cylinder to place.

        Returns
        -------
        :class:`compas_rrc.FutureResult`
            Object which blocks while waiting for feedback from robot. Calling result on
            this object will return the time the procedure took.
        """
        log.debug("Location frame: {}".format(cylinder.location))

        # change work object before placing
        self.send(SetWorkObject(self.wobjs.place))

        # move there with distance sensor TCP active
        if self.use_dist_sensor:
            tcp = self.dist_sensor_tool.name
        else:
            tcp = self.pick_place_tool.name

        self.send(SetTool(tcp))

        # start watch
        self.send(StartWatch())

        self.execute_trajectory(
            cylinder.trajectory_pick_egress_to_segment_egress,
            self.speed.travel,
            self.zone.travel,
        )

        self.execute_trajectory(
            cylinder.trajectory_segment_egress_to_place_egress,
            self.speed.travel,
            self.zone.travel,
        )

        if self.use_dist_sensor:
            self.send(SetTool(self.pick_place_tool.name))

            dist_diff = self.measure_z_diff(cylinder)

            if self.max_z_diff and self.is_dist_diff_ok(dist_diff):
                self.correct_location(cylinder, dist_diff)
            else:
                raise Exception("Unacceptable distance difference.")

        self.execute_trajectory(
            cylinder.trajectory_egress_to_top, self.speed.precise, self.zone.precise
        )

        self.send(WaitTime(self.pick_place_tool.needles_pause))
        self.retract_needles()
        self.send(WaitTime(self.pick_place_tool.needles_pause))

        self.execute_trajectory(
            cylinder.trajectory_top_to_compressed_top,
            self.speed.precise,
            self.zone.precise,
        )

        self.execute_trajectory(
            cylinder.trajectory_compressed_top_to_top,
            self.speed.precise,
            self.zone.precise,
        )

        self.execute_trajectory(
            cylinder.trajectory_top_to_egress, self.speed.precise, self.zone.precise
        )

        self.execute_trajectory(
            cylinder.trajectory_place_egress_to_segment_egress,
            self.speed.travel,
            self.zone.travel,
        )

        self.execute_trajectory(
            cylinder.trajectory_segment_egress_to_pick_egress,
            self.speed.travel,
            self.zone.travel,
        )

        self.send(StopWatch())

        return self.send(ReadWatch())

    def retract_needles(self):
        """Send signal to retract needles on pick and place tool."""
        pin = self.pick_place_tool.io_pin_needles
        state = self.pick_place_tool.retract_signal

        self.send(SetDigital(pin, state))

        log.debug("IO {} set to {}.".format(pin, state))

    def extend_needles(self):
        """Send signal to extend needles on pick and place tool."""
        pin = self.pick_place_tool.io_pin_needles
        state = self.pick_place_tool.extend_signal

        self.send(SetDigital(pin, state))

        log.debug("IO {} set to {}.".format(pin, state))

    @staticmethod
    def correct_location_in_z(cylinder, dist_diff):
        corr_vector = cylinder.get_normal() * dist_diff
        T = Translation(corr_vector)

        cylinder.location.transform(T)

        cylinder.attrs["location_correction"] = corr_vector

    @classmethod
    def from_confuse_conf(cls, ros, conf):
        pass
