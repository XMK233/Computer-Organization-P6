`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:42:47 11/23/2015 
// Design Name: 
// Module Name:    mux1 
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
module MUX_Operand1(
	input [31:0]RData1,
	input [31:0]WData,
	input [31:0]ALUResult,
	
	input [1:0]ForwardA,//choose signal
	//
	output [31:0]OperandA
    );
	assign OperandA = (ForwardA === 2'b00) ? RData1 :
							ForwardA === 2'b01 ? WData :
							ForwardA === 2'b10 ? ALUResult : 32'bxx; 

endmodule
