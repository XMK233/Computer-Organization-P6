`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:04 12/01/2015 
// Design Name: 
// Module Name:    jbunit 
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
module BU(
	input Ifbeq,
	input Ifbgtz,
	input Ifbgezal,
	input [4:0]RsD,
	input [4:0]RtD,
	input [4:0]RdM,
	input [4:0]RdW,
	input [4:0]ExDst,
	input [31:0]RData1,
	input [31:0]RData2,
	input [31:0]ALUResultM,
	input [31:0]WData,
	input RegWriteM,
	input MemtoRegM,
	input RegWriteW,
	input MemtoRegW,
	
	output [31:0]A,
	output [31:0]B,
	output [2:0]Op
    );
	reg Branch;
	always @(*) begin
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
		
		
	end
endmodule
