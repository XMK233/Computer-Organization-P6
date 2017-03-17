`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:09:50 11/23/2015 
// Design Name: 
// Module Name:    pc 
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
module PC(
    input Clk,
	 input Reset,
	 input [31:0]NPC,
	 input PCWrite,
	 output [31:0]Pc
	 );
	 reg [31:0]Pc; 
	 always @(posedge Clk) begin
		if (Reset === 1) begin
			Pc = 32'h0000_3000;
		end
		else if (PCWrite === 1) begin
			Pc = Pc;
		end
		else begin
			Pc = NPC;
		end
	 end
endmodule 
