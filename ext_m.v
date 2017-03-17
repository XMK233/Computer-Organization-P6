`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:24 12/07/2015 
// Design Name: 
// Module Name:    ext_m 
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
module EXT_M(
	input [1:0]A,
	input [31:0]Din,
	input [2:0]Op,
	output [31:0]DOut
    );
	 assign DOut = (Op === 0) ? Din :
						//lb
						(Op === 3'b001 && A === 0) ?  {{24{Din[7]}},Din[7:0]} :
						(Op === 3'b001 && A === 1) ?  {{24{Din[15]}},Din[15:8]} :
						(Op === 3'b001 && A === 2) ?  {{24{Din[23]}},Din[23:16]} :
						(Op === 3'b001 && A === 3) ?  {{24{Din[31]}},Din[31:24]} : 
						//lbu
						(Op === 3'b010 && A === 0) ?  {24'b0,Din[7:0]} :
						(Op === 3'b010 && A === 1) ?  {24'b0,Din[15:8]} :
						(Op === 3'b010 && A === 2) ?  {24'b0,Din[23:16]} :
						(Op === 3'b010 && A === 3) ?  {24'b0,Din[31:24]} : 
						//lh
						(Op === 3'b011 && A[1] === 0) ?  {{16{Din[15]}},Din[15:0]} :
						(Op === 3'b011 && A[1] === 1) ?  {{16{Din[31]}},Din[31:16]} :
						//lhu
						(Op === 3'b100 && A[1] === 0) ?  {16'b0,Din[15:0]} :
						(Op === 3'b100 && A[1] === 1) ?  {16'b0,Din[31:16]} : 32'bx;
endmodule
