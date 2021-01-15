MODULE A042_DataGlobal_Ma
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C13 / Stefano-Franscini-Platz 1
    ! CH-8093 Z�rich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A042 Driver
    !
    ! FUNCTION    :  Inclouds all project spezific global datas 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2018.06.17 Draft
    !
    ! Copyright   :  ETH Z�rich (CH) 2018
    !                - Philippe Fleischmann
    !                - Michael Lyrenmann
    !                - Gonzalo Casas
    !
    ! License     :  You agree that the software source code and documentation
    !                provided by the copyright holder is confidential, 
    !                and you shall take all reasonable precautions to protect
    !                the source code and documentation, and preserve its confidential,
    !                proprietary and trade secret status in perpetuity. 
    ! 
    !                This license is strictly limited to INTERNAL use within one site.
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A042_TaskReceiverOn:=TRUE;
    PERS bool b_A042_TaskSenderOn:=TRUE;
    !
    PERS bool b_A042_MaWaitForJob:=TRUE;
    PERS bool b_A042_MaHamModOn:=FALSE;
    PERS bool b_A042_MaInUse:=FALSE;
    PERS bool b_A042_AutoIPAddress:=TRUE;
    PERS bool b_A042_VirtualCustomPorts:=FALSE;
    !
    ! Channels
    PERS bool b_A042_Com{n_A042_NumOfCha}:=[TRUE,FALSE,FALSE,FALSE];
    PERS bool b_A042_SIDCheck{n_A042_NumOfCha}:=[TRUE,TRUE,FALSE,FALSE];
    PERS bool b_A042_SIDErrorStop{n_A042_NumOfCha}:=[FALSE,FALSE,FALSE,FALSE];
    PERS bool b_A042_LogPro{n_A042_NumOfCha}:=[FALSE,FALSE,TRUE,TRUE];
    !
    ! Client information
    PERS bool b_A042_PPMain:=TRUE;
    !
    ! Activate or deactivate a event log message 
    PERS bool b_A042_EvLogReadAndUnpackTime:=FALSE;
    PERS bool b_A042_EvLogPackAndSendTime:=FALSE;
    PERS bool b_A042_EvLogMsgInUntilMsgOutTime:=FALSE;
    !
    ! Temporary to measure the feedback loop
    PERS bool b_A042_FeedbackOut:=TRUE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    !* PERS num n_A042_WritePtrSenBufRob1:=1;
    PERS num n_A042_WritePtrSenBufMa{n_A042_NumOfCha}:=[0,0,0,0];
    PERS num n_A042_WritePtrSenBufRob{n_A042_NumOfCha}:=[5,0,0,0];
    !* PERS num n_A042_SIDMax:=8388608;
    PERS num n_A042_SIDMax:=1000000;
    !
    PERS num n_A042_R1_ChaNr:=1;
    PERS num n_A042_R2_ChaNr:=2;
    PERS num n_A042_R3_ChaNr:=3;
    PERS num n_A042_R4_ChaNr:=4;
    !
    PERS num n_A042_SocketPortRec{n_A042_NumOfCha}:=[30101,30102,30103,30104];
    PERS num n_A042_SocketPortSen{n_A042_NumOfCha}:=[30201,30202,30203,30204];
    !
    PERS num n_A042_TimeTaskLiAll:=0.1;
    PERS num n_A042_TimeTPMsg:=0.5;
    !
    PERS num n_A042_ProtocolVersion:=2;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string n_A042_Version:="1.0.0";
    !
    PERS string st_A042_JobForMa:="r_A031_HamMod";
    !
    PERS string st_A042_IP_Address:="0.0.0.0";
    PERS string st_A042_IP_AddressVC:="127.0.0.1";
    PERS string st_A042_IP_AddressMan:="192.168.125.1";
    !
    ! System data 
    PERS string st_A042_SerialNr:="46-65480";
    PERS string st_A042_SoftwareVersion:="ROBOTWARE_6.11.2019";
    PERS string st_A042_RobotWare:="6.10.00.00";
    PERS string st_A042_ControllerID:="46-65480";
    PERS string st_A042_WAN_IP:="0.0.0.0";
    PERS string st_A042_ControllerLang:="en";
    PERS string st_A042_SystemName:="C1_R1_RW6-11";

    !************************************************
    ! Declaration :     tasklist
    !************************************************
    !
    !PERS tasks tl_A042_All{5}:=[["RECEIVER"],["SENDER"],["T_MASTER"],["T_ROB21"],["T_ROB22"]];
    PERS tasks tl_A042_All{7}:=[["T_MASTER"],["RECEIVER"],["SENDER"],["T_ROB1"],[""],[""],[""]];

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    VAR syncident id_A042_MainSta;
    VAR syncident id_A042_MainEnd;
    !
    VAR syncident id_A042_InitSta;
    VAR syncident id_A042_InitMa;
    VAR syncident id_A042_InitEnd;

    !************************************************
    ! Declaration :     A042_Channel
    !************************************************
    !
    PERS A042_Channel ch_A042_Channels:=[["T_ROB1",1],["",2],["",3],["",4]];

    !************************************************
    ! Declaration :     A042_buffer_msg
    !************************************************
    !
    ! Receiver buffer for master
    PERS A042_buffer_msg bm_A042_RecBufferMa{n_A042_NumOfCha,10}:=[
    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]]];

    !
    ! Receiver buffer for robots
    PERS A042_buffer_msg bm_A042_RecBufferRob{n_A042_NumOfCha,10}:=[
    [[[113,0,15,"r_A042_WaitTime",0,0,"",0,0,5,"wobj0",0,"",0,"",0,"",0,"",0,"",0,"",0,"",1,0,-220.814,217.52,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,600,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[114,0,12,"r_A042_MoveJ",0,0,"",0,0,5,"wobj0",0,"",0,"",0,"",0,"",0,"",0,"",0,"",15,1230.51,-247.217,90.7703,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,600,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[115,0,12,"r_A042_SetDo",0,0,"",0,1,12,"doUnitC1Out1",0,"",0,"",0,"",0,"",0,"",0,"",0,"",1,0,-247.217,90.7703,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,600,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[116,0,15,"r_A042_WaitTime",0,0,"",0,0,12,"doUnitC1Out1",0,"",0,"",0,"",0,"",0,"",0,"",0,"",1,0.5,-247.217,90.7703,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,600,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[117,0,12,"r_A042_MoveL",0,0,"",0,0,12,"doUnitC1Out1",0,"",0,"",0,"",0,"",0,"",0,"",0,"",15,1221.99,-266.411,-1.36709,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,120,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[118,0,12,"r_A042_MoveJ",0,0,"",0,0,12,"doUnitC1Out1",0,"",0,"",0,"",0,"",0,"",0,"",0,"",15,1221.99,-266.411,-1.36709,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,120,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[119,0,12,"r_A042_MoveJ",0,0,"",0,0,12,"doUnitC1Out1",0,"",0,"",0,"",0,"",0,"",0,"",0,"",15,1230.51,-247.217,90.7703,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,600,200,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[120,0,12,"r_A042_MoveJ",0,0,"",0,0,12,"doUnitC1Out1",0,"",0,"",0,"",0,"",0,"",0,"",0,"",15,1242.22,-220.814,217.52,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,600,200,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[111,0,15,"r_A042_MoveAbsJ",0,0,"",0,0,5,"wobj0",0,"",0,"",0,"",0,"",0,"",0,"",0,"",14,7,4,-17,0,95,-9,0,0,0,0,0,0,600,200,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE],
    [[112,0,12,"r_A042_MoveJ",0,0,"",0,0,5,"wobj0",0,"",0,"",0,"",0,"",0,"",0,"",0,"",15,1242.22,-220.814,217.52,-0.0245702,0.193641,0.974681,-0.109072,0,0,0,0,0,0,600,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],TRUE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]]];

    !
    ! Sender buffer for master
    PERS A042_buffer_msg bm_A042_SenBufferMa{n_A042_NumOfCha,10}:=[
    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]]];

    !
    ! Sender buffer for robots
    PERS A042_buffer_msg bm_A042_SenBufferRob{n_A042_NumOfCha,10}:=[
    [[[0,0,0,"r_A042_Dummy",0,0,"Done",3,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"r_A042_MoveAbsJ",0,0,"Done",10,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"r_A042_WatchRead",0,0,"Done",38,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",1,27.899,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"r_A042_WatchRead",0,0,"Done",67,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",1,25.208,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"r_A042_WatchRead",0,0,"Done",96,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",1,26.301,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]],

    [[[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE],
    [[0,0,0,"",0,0,"",0,0,0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,"",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],FALSE]]];

ENDMODULE