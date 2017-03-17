`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:30:03 12/06/2015 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
	input signed[31:0]A,
	input signed[31:0]B,
	input [2:0]Op,
	output Br
    );
	 
	assign Br = (Op === 3'b001 && A === B) ? 1 :
					(Op === 3'b010 && A[31] === 0 && A != 0) ? 1 :
					(Op === 3'b011 && A[31] === 0) ? 1 : 
					(Op === 3'b100 && A[31] === 0) ? 1 :
					(Op === 3'b101 && (A[31] === 1 || A === 0)) ? 1 :
					(Op === 3'b110 && A[31] === 1) ? 1 : 
					(Op === 3'b111 && A!== B) ? 1 :
					0;
endmodule
