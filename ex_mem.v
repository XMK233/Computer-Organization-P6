`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:01:51 11/24/2015 
// Design Name: 
// Module Name:    ex_mem 
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
module FR_EX_MEM(
	input Clk,
	//控制信号
	input RegWriteE,
	input MemtoRegE,
   input MemWriteE,
	input [2:0]AndLinkE,
	input [31:0]PC_4E,
	//
	input [31:0]ALUResultIn,
	input [31:0]ExMidIn,
	input [4:0]ExDstIn,
	input [2:0]LsE,
	input [1:0]SsE,
	input MDOutFinE,
	//input [31:0]MDResult,
	input [31:0]Hi,
	input [31:0]Lo,
	//
	output RegWriteM,
	output MemtoRegM,
	output MemWriteM,
	output [31:0]ALUResultOut,
	output [31:0]ExMidOut,
	output [4:0]ExDstOut,
	output [2:0]LsM,
	output [1:0]SsM
    );
	 reg [31:0]data1, data2;
	 reg [4:0]data3;
	 reg data4,data5,data6;
	 reg [2:0]data7;
	 reg [1:0]data8;
	 	 
	 assign ALUResultOut = /*(AndLinkE !== 0) ? PC_4E + 4: */data1;//??
	 assign ExMidOut = data2;
	 assign ExDstOut = /*(AndLinkE === 3'b001 || AndLinkE === 3'b010) ? 31 : */data3;//??
	 assign RegWriteM = data4;
	 assign MemtoRegM = data5;
	 assign MemWriteM = data6;
	 assign LsM = data7;
	 assign SsM = data8;
	 
	 always @(posedge Clk) begin
		data1 = (AndLinkE !== 0) ? PC_4E + 4: 
				  (MDOutFinE === 1) ? Hi://如果出现逻辑错误试一试将这句话的条件改为MDResult !== 32'bx,因为MDResult不是有数值就是x，有数值就是应该被输出的
				  (MDOutFinE === 0) ? Lo :
					ALUResultIn;
		data2 = ExMidIn;
		data3 =	(AndLinkE === 3'b001 || AndLinkE === 3'b010) ? 31 : ExDstIn;
		data4 = RegWriteE;
		data5 = MemtoRegE;
		data6 = MemWriteE;
		data7 = LsE;
		data8 = SsE;
	 end
endmodule
/*initial begin
		data1 = 0;
		data2 = 0;
		data3 = 0;
		data4 = 0;
		data5 = 0;
		data6 = 0;
	 end*/