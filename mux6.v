`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:34:39 12/08/2015 
// Design Name: 
// Module Name:    mux6 
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
module MUX_OperandFinal(
	input [31:0]Operate1,
	input [31:0]Operate2,
	input [4:0]Imm,
	input [4:0]ALUCtrl,
	output [31:0]Operand1,
	output [31:0]Operand2,
	output [4:0]ALUCtrlFin
    );
	 assign Operand1 = ((ALUCtrl === 5'b00100) || (ALUCtrl === 5'b00101) || (ALUCtrl === 5'b00110)) ? Operate2 : Operate1;
	 assign Operand2 = ((ALUCtrl === 5'b00100) || (ALUCtrl === 5'b00101) || (ALUCtrl === 5'b00110)) ? {27'b0, Imm} : Operate2;
	 assign ALUCtrlFin = ALUCtrl;
endmodule
