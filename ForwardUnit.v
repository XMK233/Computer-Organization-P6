`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:41:43 11/24/2015 
// Design Name: 
// Module Name:    ForwardUnit 
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
module ForwardUnit(
    input [4:0]RsE,
    input [4:0]RtE,
    input [4:0]RdM,
    input [4:0]RdW,
    input RegWriteM,
    input RegWriteW,
	 //input [4:0]ALUCtrl,
    output [1:0]ForwardA,
    output [1:0]ForwardB
	 //output ForwardImm
    );
	 assign ForwardA = (RegWriteM === 1 && (RdM !== 0) && (RdM === RsE)) ? 2'b10 :
							 (RegWriteW === 1 && (RdW !== 0) && (RdW === RsE)) ? 2'b01 : 
							  2'b00;/*&& ~(RegWriteM === 1 && (RdM !== 0) && (RdM !== RsE))*/ 
	 assign ForwardB = (RegWriteM === 1 && (RdM !== 0) && (RdM === RtE)) ? 2'b10 : 
							 (RegWriteW === 1 && (RdW !== 0) && (RdW === RtE)) ? 2'b01 : 
							  2'b00;/*&& ~(RegWriteM === 1 && (RdM !== 0) && (RdM !== RtE))*/ 
	 //assign ForwardImm = ((ALUCtrl === 5'b00100) || (ALUCtrl === 5'b00101) || (ALUCtrl === 5'b00110)) ? 1 : 0;
endmodule
