`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:55:00 12/07/2015 
// Design Name: 
// Module Name:    mux_andlink 
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
module MUX_AndLink(
	input Ifjal, 
	input Ifbgezal,
	input Ifjalr,
	input [4:0]RdD,
	input [31:0]PC_4,
	input [4:0]WA,
	input [31:0]WD,
	//input  RegWriteW,
	output [4:0]WriteAddress,
	output [31:0]WriteData,
	output We
    );
	assign WriteAddress = (Ifjal === 1 || Ifbgezal === 1) ? 31 : 
									(Ifjalr === 1) ? RdD :
									WA;
	assign WriteData = ( Ifjal === 1 || Ifbgezal === 1 || Ifjalr === 1) ? PC_4 + 4 : WD;  
endmodule
