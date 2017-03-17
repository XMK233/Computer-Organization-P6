`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:22:11 11/24/2015 
// Design Name: 
// Module Name:    mux4 
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
module MUX_MemOrALU(
	input [31:0]MemDataIn,
	input [31:0]ALUResultIn,
	input MemtoReg,
	output [31:0]WData
    );
	assign WData = (MemtoReg === 1) ? MemDataIn : ALUResultIn;
endmodule
