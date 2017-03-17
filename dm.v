`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:40 11/23/2015 
// Design Name: 
// Module Name:    dm 
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
module DM(
    input [12:2]A,
	 input [3:0]BE,
    input [31:0]WD,
    output [31:0]RD,
    input we,//enable
    input clk
    );
	 reg [31:0]dm[2047:0];
	 reg [31:0]temp;
	 reg [7:0]temp0,temp1,temp2,temp3;
	 integer i; 
	 initial begin
		for (i = 0; i < 2048; i = i + 1 ) begin
					dm[i] <= 32'b0;
				end
	 end
	 always @(posedge clk) begin
			if (we === 1) begin
				temp = dm[A];
				if (BE === 4'b1111) begin
					temp0 = (BE[0] === 1) ? WD[7:0] : temp[7:0];
					temp1 = (BE[1] === 1) ? WD[15:8] : temp[15:8];
					temp2 = (BE[2] === 1) ? WD[23:16] : temp[23:16];
					temp3 = (BE[3] === 1) ? WD[31:24] : temp[31:24];
				end
				else if(BE === 4'b0011)  begin
					temp0 = WD[7:0];
					temp1 = WD[15:8];
					temp2 = temp[23:16];
					temp3 = temp[31:24];
				end
				else if (BE === 4'b1100) begin
					temp0 = temp[7:0];
					temp1 = temp[15:8];
					temp2 = WD[7:0];
					temp3 = WD[15:8];
				end
				else if (BE === 4'b0001 || BE === 4'b0010 || BE === 4'b0100 || BE === 4'b1000) begin
					temp0 = (BE[0] === 1) ? WD[7:0] : temp[7:0];
					temp1 = (BE[1] === 1) ? WD[7:0] : temp[15:8];
					temp2 = (BE[2] === 1) ? WD[7:0] : temp[23:16];
					temp3 = (BE[3] === 1) ? WD[7:0] : temp[31:24];
				end
				else begin
					temp0 = temp[7:0];
					temp1 = temp[15:8];
					temp2 = temp[23:16];
					temp3 = temp[31:24];
				end
				$display("*%x <= %x", A, {temp3, temp2, temp1, temp0});//////////////////////////////////////
				dm[A] = {temp3, temp2, temp1, temp0};	
			end
			//dm[A] = {temp[3],temp[2],temp[1],temp[0]};
    end
	 assign RD = dm[A];
endmodule
/*if(BE[0] === 1) begin
					dm[A] = {temp[31:8], WD[7:0]};
				end
				if(BE[1] === 1) begin
					dm[A] = {temp[31:16], WD[15:8], temp[7:0]};
				end
				if(BE[2] === 1) begin
					dm[A] = {temp[31:24], WD[23:16], temp[15:0]};
				end
				if(BE[3] === 1) begin
					dm[A] = {WD[31:24],temp[23:0]};
				end*/
				/*
				temp0 = (BE[0] === 1) ? WD[7:0] : temp[7:0];
				temp1 = (BE[1] === 1) ? WD[15:8] : temp[15:8];
				temp2 = (BE[2] === 1) ? WD[23:16] : temp[23:16];
				temp3 = (BE[3] === 1) ? WD[31:24] : temp[31:24];*/