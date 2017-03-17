`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:47:51 11/23/2015 
// Design Name: 
// Module Name:    mux2 
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
module MUX_Operand2(
	input [31:0]RData2,
	input [31:0]WData,
	input [31:0]ALUResult,
	input [31:0]Imm32,
	input ALUSrcE,
	input [1:0]ForwardB,
	//
	output [31:0]OperandB,
	output [31:0]ExMid
    );
	wire [31:0]OperandCurrent;
	assign OperandCurrent = ForwardB === 2'b00 ? RData2 :
									ForwardB === 2'b01 ? WData :
									ForwardB === 2'b10 ? ALUResult : 
									32'bxx; 
	//
	assign OperandB = ALUSrcE ? Imm32 : OperandCurrent;
	assign ExMid = OperandCurrent;
endmodule
