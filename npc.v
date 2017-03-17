`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:10:26 11/23/2015 
// Design Name: 
// Module Name:    npc 
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
////////////////////////////////////////////////////////////////////////////////////(Ifbgtz === 1'b1 && (RData1[31] === 1'b0 && RData1 !== 0)) ? PCID + {InstructionID[15:0], 2'b00} : 
module NPC(
    input [31:0]PC,
	 input [31:0]PCID,
	 input [31:0]InstructionID,
	 	 
	 input Ifj,
	 input Ifjal,
	 input Ifjr,
	 input Ifjalr,
	 input [31:0]nPCin,
	 input IfBranch,
	 
	 output [31:0]nPC
	 );
	 
	 assign nPC = (Ifj === 1'b1 || Ifjal === 1) ? {PCID[31:28], InstructionID[25:0], 2'b00} : 
					  (IfBranch === 1) ? PCID + {{14{InstructionID[15]}},InstructionID[15:0], 2'b00} :
					  (Ifjr === 1 || Ifjalr === 1) ? nPCin : PC + 32'b100;
						
endmodule
