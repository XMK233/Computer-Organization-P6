`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:02 11/24/2015 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(
    input clk,
    input reset
    );
	 wire rst = reset;
	 wire [3:0]BE;
	 wire [31:0]InstructionIF, npc ,pc,pcid ,InstructionID, InstructionCurrent, WData, ALUResultM, ALUResultE,
						ImmExted1,ImmExted2, OperandA, OperandB, ExMid, RData1, RData2, RData1Ex,Dout,
						RData2Ex, ExMidM, dout,Memdout,ALUResultW,nPCin, CMPA, CMPB, ALUOperandA, ALUOperandB, PC_4E,
						HI, LO, MDResult1;
	 wire [2:0] BOp, LsD, LsE, LsM, LsW, AndLinkD, AndLinkE, MDOpD, MDOpE;
	 wire [4:0] ExDst, RtE, RsE, RdW, RdE, RdM, ALUCtrlD, ALUCtrlE, ALUCtrlFin, Imm5;
	 wire [1:0] ForwardA, ForwardB, SsD, SsE, SsM;
	 wire RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD,RegWriteE,MemtoRegE,MemWriteE,ALUSrcE,
						RegDstE,RegWriteM,MemtoRegM,MemWriteM,RegWriteW,MemtoRegW,
						JumpToTargetD,JumpAndLinkD,JumpRegD,IFIDWrite, PCWrite,/*BeqD,BgtzD,BgezalD,*/
						Zero,BranchEn,JumpRegEn,BubbleEn, JumpAndLinkRegD, Busy, HiLoD, StartD, MDWeD, MDOutFinD, HiLoE, StartE, MDWeE, MDOutFinE, MDSignalD, MDSignalE;
										
	PC Pc ( clk,  rst, npc[31:0], PCWrite, pc[31:0]);
	
	JU jumpunit (InstructionID[31:0], RegWriteM,	RegWriteW, MemtoRegM, MemtoRegW,	InstructionID[25:21], RdM[4:0],
						RdW[4:0], ALUResultM[31:0], WData[31:0], RData1[31:0], JumpRegEn,	JumpAndLinkRegEn, nPCin[31:0] );		
						
	NPC Npc (pc[31:0], pcid[31:0], InstructionID[31:0], JumpToTargetD, JumpAndLinkD,	JumpRegD,	JumpAndLinkRegD, nPCin[31:0],
				BranchEn, npc[31:0]);		
				
	IM im ( pc[12:2], InstructionIF[31:0]);
	
	FR_IF_ID if_id ( clk, InstructionIF[31:0], IFIDWrite, pc[31:0], InstructionID[31:0], pcid[31:0]);
	
	MUX_Bubble mux_bubble (InstructionID[31:0], BubbleEn, InstructionCurrent[31:0] );
	
	Controller controller (InstructionCurrent[31:0], RegWriteD,
								  MemtoRegD,MemWriteD,
								  ALUCtrlD[4:0],
								  ALUSrcD,RegDstD, AndLinkD, JumpToTargetD, JumpAndLinkD, JumpRegD, JumpAndLinkRegD, /*BgtzD, BeqD, BgezalD,*/
								  LsD[2:0], SsD[1:0], MDOpD[2:0], HiLoD, StartD, MDWeD, MDOutFinD, MDSignalD);
								  
	/*MUX_AndLink mux_andlink(JumpAndLinkD, BgezalD,	JumpAndLinkRegD, InstructionID[15:11], pcid[31:0],	RdW[4:0], 
									WData[31:0],	WA[4:0],	WD[31:0]);*/
	
	GPR gpr (InstructionID[25:21],InstructionID[20:16], RdW[4:0], RData1[31:0], RData2[31:0],	WData[31:0], RegWriteW,
				clk,	rst);
				
	BU_F branchunit_forward(InstructionID[31:0],	/*InstructionID[25:21], InstructionID[20:16],	*/RdM[4:0],RdW[4:0],
								 RData1[31:0],	 RData2[31:0],	 ALUResultM[31:0], WData[31:0], RegWriteM, MemtoRegM,
								 RegWriteW,CMPA[31:0], CMPB[31:0], BOp[2:0]);
								 
	CMP cmp (CMPA[31:0],	CMPB[31:0],	BOp[2:0],BranchEn );
	
	FR_ID_EX id_ex(clk,	RegWriteD,	MemtoRegD,	MemWriteD, ALUCtrlD[4:0],	ALUSrcD,	RegDstD,	LsD[2:0], SsD[1:0],
						AndLinkD[2:0], pcid[31:0], RData1[31:0],	RData2[31:0], InstructionID[15:0],	InstructionID[10:6], InstructionID[25:21],
						InstructionID[20:16],	InstructionID[15:11], MDOpD[2:0], HiLoD, StartD, MDWeD, MDOutFinD, MDSignalD,
						RegWriteE, MemtoRegE,	MemWriteE,	ALUCtrlE[4:0],	ALUSrcE,	RegDstE,	LsE[2:0], SsE[1:0],	AndLinkE[2:0], PC_4E[31:0], RData1Ex[31:0],
						RData2Ex[31:0], ImmExted1[31:0],	Imm5[4:0],	RsE[4:0], RtE[4:0],	RdE[4:0], 
						MDOpE[2:0], HiLoE, StartE, MDWeE, MDOutFinE, MDSignalE);
						
	EXT ext (ImmExted1[31:0],	ALUCtrlE[4:0],	ImmExted2[31:0]);////
	
	MUX_Operand1 mux_opr1 ( RData1Ex[31:0],  WData[31:0], ALUResultM[31:0],  ForwardA[1:0], OperandA[31:0]);
	
	MUX_Operand2 mux_opr2 ( RData2Ex[31:0],  WData[31:0],  ALUResultM[31:0], ImmExted2[31:0],  ALUSrcE,  ForwardB[1:0],
								   OperandB[31:0],  ExMid[31:0]);
								  
	MUX_OperandFinal mux_operandfinal( OperandA[31:0],	 OperandB[31:0], Imm5[4:0], ALUCtrlE[4:0],
												  ALUOperandA[31:0], ALUOperandB[31:0], ALUCtrlFin[4:0]);
	
	ALU alu (ALUOperandA[31:0],ALUOperandB[31:0],ALUCtrlFin[4:0],
				ALUResultE[31:0],	Zero);
				
	MULT_DIV mult_div (ALUOperandA[31:0], ALUOperandB[31:0], HiLoE, MDOpE[2:0], StartE, MDWeE, Busy, HI[31:0], LO[31:0], clk, rst);

	/*MUX_HiOrLo mux_hiorlo(HI[31:0], LO[31:0], MDOutFinE, 
									MDResult1[31:0]);	*/
		
	MUX_Dst mux_dst (	RtE[4:0],RdE[4:0],RegDstE,						
							ExDst[4:0]);
							
	FR_EX_MEM ex_mem (clk,RegWriteE,	MemtoRegE, MemWriteE,AndLinkE[2:0], PC_4E[31:0], ALUResultE[31:0],	ExMid[31:0],ExDst[4:0],	LsE[2:0],SsE[1:0], MDOutFinE, HI[31:0], LO[31:0],
							RegWriteM,MemtoRegM,MemWriteM,ALUResultM[31:0],	ExMidM[31:0],RdM[4:0],LsM[2:0],SsM[1:0]);
							
	ForwardUnit forwardunit ( RsE[4:0], RtE[4:0],RdM[4:0], RdW[4:0], RegWriteM, RegWriteW, /*ALUCtrlE[4:0],*/
									 ForwardA[1:0], ForwardB[1:0]/*, ForwardImm*/);
									 
	DM_BE dm_be ( ALUResultM[1:0], SsM[1:0],	 
					  BE[3:0]);
						
	DM dm ( ALUResultM[12:2], BE[3:0], ExMidM[31:0],
			 Dout[31:0],
			 MemWriteM, clk);		
			 
	FR_MEM_WB mem_wb(  clk, RegWriteM, MemtoRegM, Dout[31:0], ALUResultM[31:0], RdM[4:0], LsM[2:0],
					       RegWriteW, MemtoRegW, Memdout[31:0], ALUResultW[31:0],RdW[4:0],  LsW[2:0]);
					  
	EXT_M ext_w ( ALUResultW[1:0], Memdout[31:0], LsW[2:0], dout[31:0]);

	MUX_MemOrALU mux_moa(dout[31:0],ALUResultW[31:0], MemtoRegW,
								WData[31:0]	);
								
	HSU hsu (InstructionID[31:0],	ExDst[4:0],RdM[4:0], BOp[2:0], JumpRegEn, JumpAndLinkRegEn, MemtoRegE,MemtoRegM,RegWriteE, Busy, MDSignalE, 
				IFIDWrite, PCWrite,	BubbleEn	);
				
endmodule 