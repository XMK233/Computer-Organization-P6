`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:19 12/06/2015 
// Design Name: 
// Module Name:    bunit 
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
module BU_F(
	input [31:0]Instruction,
	
	//input [4:0]RsD,
	//input [4:0]RtD,
	input [4:0]RdM,
	//input [4:0]RtM,
	input [4:0]RdW,
	
	input [31:0]RData1,
	input [31:0]RData2,
	input [31:0]ALUResultM,
	input [31:0]WData,
	
	input RegWriteM,
	input MemtoRegM,
	input RegWriteW,
	
	output reg [31:0]A,
	output reg [31:0]B,
	output [2:0]Op
    );
	 wire [4:0] RsD, RtD;
	 wire Ifbeq, Ifbgtz,Ifbne, Ifblez, Ifbltz, Ifbgez,  Ifbgezal,fcbgezal,fcbgtz;
	 wire [5:0]func,op;
	 
	 assign RsD = Instruction[25:21];
	 assign RtD = Instruction[20:16];
	 
	 assign func = Instruction[5:0];
	 assign op = Instruction[31:26];
	 assign fcbgtz = (~Instruction[20] & ~Instruction[19] & ~Instruction[18] & ~Instruction[17] & ~Instruction[16]);
	 assign fcbgezal = (Instruction[20] & ~Instruction[19] & ~Instruction[18] & ~Instruction[17] & Instruction[16]);
	 
	 assign Ifbeq = (~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0]);
	 assign Ifbgtz = (~op[5] & ~op[4] & ~op[3] & op[2] & op[1] & op[0] & fcbgtz);
	 assign Ifbgezal = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0] & fcbgezal);	 
	 assign Ifbgez = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0] & ~Instruction[20] & ~Instruction[19] & ~Instruction[18] & ~Instruction[17] & Instruction[16]);
	 assign Ifblez = (~op[5] & ~op[4] & ~op[3] & op[2] & op[1] & ~op[0] & ~Instruction[20] & ~Instruction[19] & ~Instruction[18] & ~Instruction[17] & ~Instruction[16]);
	 assign Ifbltz = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0] & ~Instruction[20] & ~Instruction[19] & ~Instruction[18] & ~Instruction[17] & ~Instruction[16]);
	 assign Ifbne = (~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0]);
	 assign Op = (Ifbeq === 1) ? 3'b001 :
					 (Ifbgtz === 1) ? 3'b010 :
					 (Ifbgezal === 1) ? 3'b011 : 
					 (Ifbgez === 1) ? 3'b100 :
					 (Ifblez === 1) ? 3'b101 :
					 (Ifbltz === 1) ? 3'b110 :
					 (Ifbne === 1) ? 3'b111 :
					 3'b0;
	always @(*) begin
		if (RsD === RdM && RegWriteM === 1 && MemtoRegM === 0) 
			A = ALUResultM;
		/*else if (RsD === RtM && RegWriteM === 1 && MemtoRegM === 0)
			A = ALUResultM;*/
		else if (RsD === RdW && RegWriteW === 1)
			A = WData;
		else 
			A = RData1;
		//
		if (RtD === RdM && RegWriteM === 1 && MemtoRegM === 0) 
			B = ALUResultM;
		/*else if (RtD === RtM && RegWriteM === 1 && MemtoRegM === 0)
			B = ALUResultM;*/
		else if (RtD === RdW && RegWriteW === 1)
			B = WData;
		else 
			B = RData2; 
	end
endmodule 
/*always @(*) begin
		if (Ifbeq === 1) begin
			if(RegWriteM === 1 && MemtoRegM === 0) begin
				Branch = ((RsD === RdM && (ALUResultM - RData2 === 0)) || (RtD === RdM && (ALUResultM - RData1 === 0))) ? 1 : 0 ;
			end//mem
			else if (RegWriteW === 1 && MemtoRegW === 1) begin
				Branch = ((RsD === RdW && (WData - RData2 === 0)) || (RtD === RdW && (WData - RData1 === 0))) ? 1 : 0;
			end//wb
			else begin 
				Branch = (RData1 - RData2 === 0) ? 1 : 0;
			end//Œﬁ√∞œ’
		end///////////////////
		else if ( Ifbgtz === 1) begin
			if (RegWriteM === 1 && MemtoRegM === 0) begin
				Branch =( ALUResultM[31]	=== 0 ) ? 1 : 0 ;
			end//mem
			else if (RegWriteW === 1 && MemtoRegW === 1) begin
				Branch = (WData[31] === 0) ? 1 : 0;
			end//wb
			else begin
				Branch = (RData1[31] === 0) ? 1 : 0;
			end//no hazard
		end//////////////////
		else if(Ifbgezal === 1) begin
			if (RegWriteM === 1 && MemtoRegM === 0 && RsD === RdM ) begin
				Branch =( ALUResultM[31]	=== 0 ) ? 1 : 0 ;
			end//mem
			else if (RegWriteW === 1 && MemtoRegW === 1 &&  RsD === RdW ) begin
				Branch = (WData[31] === 0) ? 1 : 0;
			end//wb
			else begin
				Branch = (RData1[31] === 0) ? 1 : 0;
			end//no hazard
		end/////////////////////
		else
			Branch = 0;		
	end*/