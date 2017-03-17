`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:20:51 12/07/2015 
// Design Name: 
// Module Name:    extend 
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
module EXT(
	input [31:0]Imm32,
	input [4:0]ALUCtrlD,
	output [31:0]ImExt
    );
	 assign ImExt = (ALUCtrlD === 5'b010 || ALUCtrlD === 5'b10000) ? Imm32 : {{16{Imm32[15]}}, Imm32[15:0]};//ori?


endmodule
