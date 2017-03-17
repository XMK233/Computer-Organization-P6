`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:46:56 12/21/2015 
// Design Name: 
// Module Name:    mux7 
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
module MUX_HiOrLo(
	input [31:0]HI,
	input [31:0]LO,
	input MDOutFin,
	output MDResult
    );
	assign MDResult = (MDOutFin === 1) ? HI :
							(MDOutFin === 0) ? LO : 
							32'bx;
endmodule
