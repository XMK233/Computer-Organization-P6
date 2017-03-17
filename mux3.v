`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:40:50 11/24/2015 
// Design Name: 
// Module Name:    mux3 
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
module MUX_Dst(
	input [4:0]Rt,
	input [4:0]Rd,
	input RegDst,
	output [4:0]ExDst// mind the select signal
    );
	 
	 assign ExDst = (RegDst === 1) ?  Rd : Rt;


endmodule
