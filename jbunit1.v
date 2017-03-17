`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:15 12/01/2015 
// Design Name: 
// Module Name:    jbunit1 
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
module JU(
	input [31:0]Instruction,
	input RegWriteM,
	input RegWriteW,
	input MemtoRegM,
	input MemtoRegW,
	input [4:0]RsD,
	input [4:0]RdM,
	input [4:0]RdW,
	input [31:0]ALUResultM,
	input [31:0]WData,
	input [31:0]RData1,
	output JumpReg,
	output JumpAndLinkReg,
	output [31:0]nPCin
    );
	 wire Ifjr;
	 wire Ifjalr;
	 wire [5:0]func,op;
	 assign func = Instruction[5:0];
	 assign op = Instruction[31:26];
	 assign fcjr = (~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & ~func[0]);
	 assign Ifjr = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcjr);
	 assign Ifjalr = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & func[0]);
	//专门产生j类控制信号
	assign JumpReg = Ifjr; 
	assign JumpAndLinkReg = Ifjalr;
	assign nPCin = ((Ifjr === 1 || Ifjalr === 1) && RegWriteM === 1 && MemtoRegM === 0 && (RsD === RdM)) ? ALUResultM : 
					   ((Ifjr === 1 || Ifjalr === 1) && RegWriteW === 1 && MemtoRegW === 1 && (RsD === RdW)) ? WData : 
						RData1;
endmodule
