`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:22:04 12/07/2015
// Design Name:   mips
// Module Name:   G:/ISE Files/p6/test.v
// Project Name:  p6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		clk = 0;
		rst = 1;
		#1;
		rst = 0;
	end
	
	
	always begin
		clk = ~clk;
		#5;
	end 
      
endmodule

