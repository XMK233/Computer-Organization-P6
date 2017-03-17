`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:47:04 12/22/2015
// Design Name:   MULT_DIV
// Module Name:   G:/ISE Files/p6/testMD.v
// Project Name:  p6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MULT_DIV
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testMD;

	// Inputs
	reg [31:0] D1;
	reg [31:0] D2;
	reg HiLo;
	reg [1:0] Op;
	reg Start;
	reg We;
	reg Clk;
	reg Rst;

	// Outputs
	wire Busy;
	wire [31:0] HI;
	wire [31:0] LO;

	// Instantiate the Unit Under Test (UUT)
	MULT_DIV uut (
		.D1(D1), 
		.D2(D2), 
		.HiLo(HiLo), 
		.Op(Op), 
		.Start(Start), 
		.We(We), 
		.Busy(Busy), 
		.HI(HI), 
		.LO(LO), 
		.Clk(Clk), 
		.Rst(Rst)
	);

	initial begin
		// Initialize Inputs
		D1 = 0;
		D2 = 0;
		HiLo = 0;
		Op = 0;
		Start = 0;
		We = 0;
		Clk = 0;
		Rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

