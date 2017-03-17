`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:25:38 11/24/2015 
// Design Name: 
// Module Name:    Hazard 
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
module HSU(
	input [31:0]Instruction,
	input [4:0]RtE,
	input [4:0]RdM,
	input [2:0]Op,
	input JumptoReg,
	input JumpAndLinkReg,
	input MemReadE,
	input MemReadM,
	input RegWriteE,
	input busy,
	input MDSignalE,
	//
	output IFIDWrite,
	output PCWrite,
	output Bubble//使得
    );
	 wire [4:0]RsD = Instruction[25:21];
	 wire [4:0]RtD = Instruction[20:16];
	 wire Pause, MDSignal;
	 //乘除法相关信号的译码
	wire [5:0]func,op;
	wire mflo, mfhi, mtlo, mthi, mult, multu, div, divu, msub;
	assign func = Instruction[5:0];
	assign op = Instruction[31:26];
	assign mfhi = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0]);
	assign mflo = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & ~func[3] & ~func[2] & func[1] & ~func[0]);
	assign mthi = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & ~func[3] & ~func[2] & ~func[1] & func[0]);
	assign mtlo = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & ~func[3] & ~func[2] & func[1] & func[0]);
	assign mult = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & func[3] & ~func[2] & ~func[1] & ~func[0]);
	assign multu = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & func[3] & ~func[2] & ~func[1] & func[0]);
	assign div = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & func[3] & ~func[2] & func[1] & ~func[0]);
	assign divu = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & func[3] & ~func[2] & func[1] & func[0]);
	assign msub = (~op[5] & op[4] & op[3] & op[2] & ~op[1] & ~op[0] & ~func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0]);
	assign MDSignal = mflo | mfhi | mtlo | mthi | mult | multu | div | divu | msub; 
	//
	 assign Pause = ((/*RegWriteE === 1||*/MemReadE === 1 /*|| MemReadM === 1*/) && ((RtE === RsD) || (RtE === RtD))) ? 1 : //装载机指令的延迟
								(RegWriteE === 1 && Op !== 0 && (RtE === RsD || RtE === RtD)) ? 1 : //b类延迟一个周期
								(Op !== 0 && MemReadM === 1 && ((RdM === RsD) || (RdM === RtD))) ? 1 ://b类延迟第二个周期
								((JumptoReg === 1 || JumpAndLinkReg) && RegWriteE === 1 && RtE === RsD) ? 1 ://jr延迟一个周期 
								((JumptoReg === 1 || JumpAndLinkReg)&& MemReadM === 1 && RdM === RsD) ? 1 ://jr延迟第二个周期
								//乘除法系列的暂停
								(MDSignal === 1 && MDSignalE === 1) ? 1 :
								(busy === 1 && MDSignal === 1) ? 1 : 
								0;
	 assign IFIDWrite = Pause;
	 assign PCWrite = Pause;
	 assign Bubble = Pause;
endmodule
