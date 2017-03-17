`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:31:16 12/07/2015 
// Design Name: 
// Module Name:    dmbe 
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
module DM_BE(
    input [1:0]Addr,
    input [1:0]SsM,
    output [3:0]BE
    );
	assign BE = //sb
					(SsM === 1 && Addr === 0) ?  4'b0001 :
					(SsM === 1 && Addr === 1) ?  4'b0010 :
					(SsM === 1 && Addr === 2) ?  4'b0100 :
					(SsM === 1 && Addr === 3) ?  4'b1000 : 
					//
					(SsM === 2 && Addr[1] === 0) ? 4'b0011 :
					(SsM === 2 && Addr[1] === 1) ? 4'b1100 :
					//sw
					(SsM === 3) ? 4'b1111 :
					4'b0000;

endmodule
