`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:13 11/24/2015 
// Design Name: 
// Module Name:    mux5 
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
module MUX_Bubble(
	input [31:0]Instruction,
	input IfBubble,
	output [31:0]InstructionCurrent
    );
	assign InstructionCurrent = IfBubble=== 1 ? 3'b0 : Instruction;

endmodule
