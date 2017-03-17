`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:42 11/23/2015 
// Design Name: 
// Module Name:    gpr 
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
module GPR(
    input [4:0]A1,
    input [4:0]A2,
    input [4:0]A3,//write address
    output [31:0]RD1,
    output [31:0]RD2,
    input [31:0]WD,// write data
    input We,// register write enable
    input Clk,
	 input Rst
	 );
	reg [31:0]data[31:0]/*, RD1, RD*/;
	integer i;
	initial begin
		for (i = 0; i<32; i = i + 1) begin
			data[i] = i === 28 ? 6144 :
						 i === 29 ? 12284 :
						 32'b0;
		end
	end
	always @(negedge Clk) begin
		if (Rst === 1)begin
			for (i = 0; i<32; i = i + 1)
				data[i] = 32'b0;
		end//清空		
		if (We === 1 ) begin
			if (A3 !== 0 ) begin
				$display("$%d = %x", A3, WD);///////////////////////////////////////////////////////
				data[A3] = WD;
			end
		end
		//RD1 <= data[A1];
		//RD2 <= data[A2];
	end
	
	assign RD1 = /*(A1 !== A3) ? */data[A1] /*: WD*/;//内部转发
	assign RD2 = /*(A2 !== A3) ? */data[A2] /*: WD*/;
endmodule 

/*if (Ifjal === 1 || Ifbgezal === 1) begin
					data[31] = PC_4 + 4;
				end//link的存储*/
				
//input Ifjal, 
//input Ifbgezal,
//input [31:0]PC_4
    