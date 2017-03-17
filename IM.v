`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:40 11/23/2015 
// Design Name: 
// Module Name:    im 
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
module IM(
    input [12:2]addr,
	 output [31:0]dout
	 );
	 //
	 reg [31:0]im[2047:0];
	 initial begin
	   	$readmemh("code.txt", im);
	 end
	 assign dout = im[addr - 1024];
	 //
endmodule 
