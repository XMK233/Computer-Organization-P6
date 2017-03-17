`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:00 11/23/2015 
// Design Name: 
// Module Name:    FR_ID_EX 
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
module FR_ID_EX(
    input Clk,
	 //控制单元的输入
	 input RegWriteD,//WB
	 input MemtoRegD,
	 input MemWriteD,//m
    input [4:0]ALUCtrlD,//Ex
    input ALUSrcD,//Ex
    input RegDstD,//WB
	 input [2:0]LsD,
	 input [1:0]SsD,
	 input [2:0]AndLinkD,
	 input [31:0]PC_4D,
	 //操作数
	 input [31:0]RData1In,
	 input [31:0]RData2In,
	 //立即数和寄存器号的输入
	 input [15:0]InstructionImm,
	 input [4:0]InstructionImm5,
	 input [25:21]InstructionRs,
	 input [20:16]InstructionRt,
	 input [15:11]InstructionRd,
	 input [2:0]MDOpD,
	 input HiLoD,
	 input StartD,
	 input MDWeD,
	 input MDOutFinD,
	 input MDSignalD,
	 //输出
	 output RegWriteE,
	 output MemtoRegE,
	 output MemWriteE,
    output [4:0]ALUCtrlE,
    output ALUSrcE,
    output RegDstE,
	 output [2:0]LsE,
	 output [1:0]SsE,
	 output [2:0]AndLinkE,
	 output [31:0]PC_4E,
	 output [31:0]RData1Out,
	 output [31:0]RData2Out,
	 output [31:0]Imm32,
	 output [4:0]Imm5,
	 output [4:0]Rs,
	 output [4:0]Rt,
	 output [4:0]Rd,
	 output [2:0]MDOpE,//乘除符号
	 output HiLoE,
	 output StartE,
	 output MDWeE,
	 output MDOutFinE,
	 output MDSignalE
	 ////output BranchE,
    );
	 //23 regs
	reg data1, data2,data3, data5,data6,data13;
	reg data20, data21, data22, data23, data24;
	reg [31:0] data8, data7, data18;
	reg [15:0]data9;
	reg [25:21]data10, data11, data12;
	reg [2:0]data14, data17, data19;
	reg [1:0]data15;
	reg [4:0]data16,data4;
	assign RegWriteE = data1;
	assign ALUCtrlE = data4;
	assign ALUSrcE = data5;
	assign RegDstE = data6;
	//assign BranchE = data13;
	assign RData1Out = data7;
	assign RData2Out = data8;
	assign Imm32 = {16'b0, data9};//???
	assign Rs = data10;
	assign Rt = data11;
	assign Rd = data12;
	assign MemtoRegE = data2;
	assign MemWriteE = data3;
	//assign BeqE = data13;
	assign LsE = data14;
	assign SsE = data15;
	assign Imm5 = data16;
	assign AndLinkE = data17;
	assign PC_4E = data18;
	assign MDOpE = data19;
	assign HiLoE = data20;
	assign StartE = data21;
	assign MDWeE = data22;
	assign MDOutFinE = data23;
	assign MDSignalE = data24;
	
	//寄存
	always @(posedge Clk) begin//store the data
		data1 = RegWriteD;
		data2 = MemtoRegD;
		data3 = MemWriteD;
		data4 = ALUCtrlD;
		data5 = ALUSrcD;
		data6 = RegDstD;
		data7 = RData1In;
		data8 = RData2In;
		data9 = InstructionImm;
		data10 = InstructionRs;
		data11 = InstructionRt;
		data12 = InstructionRd;
		//data13 = BeqD;
		data14 = LsD;
		data15 = SsD;
		data16 = InstructionImm5;
		data17 = AndLinkD;
		data18 = PC_4D;
		data19 = MDOpD;
		data20 = HiLoD;
		data21 = StartD;
		data22 = MDWeD;
		data23 = MDOutFinD;
		data24 = MDSignalD;
	end
	
endmodule
/*initial begin
		data1 = 0;
		data2 = 0;
		data3 = 0;
		data4 = 0;
		data5 = 0;
		data6 = 0;
		data7 = 0;
		data8 = 0;
		data9 = 0;
		data10 = 0;
		data11 = 0;
		data12 = 0;
		data13 = 0;
	end*/
	//输出
