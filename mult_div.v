`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:39 12/09/2015 
// Design Name: 
// Module Name:    mult_div 
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
module MULT_DIV(
    input signed [31:0]D1,
    input signed [31:0]D2,
    input HiLo,
    input [2:0]Op,//0 mult, 1 multu, 2 div, 3 divu
    input Start,//���Կ�����
    input We,//���Կ�����, mtlo mthi
    output reg Busy,//���ص�hsu
    output [31:0]HI,
    output [31:0]LO,
    input Clk,
    input Rst
    );
	integer signed mulCount, divCount;
	//
	initial begin
		Busy = 0;
		mulCount = 5;//������
		divCount = 10;
	end
	reg [31:0]dataHi, dataLo;//hilo�Ĵ���
	reg [63:0]resultSigned, resultSignedM, resultSignedD, remainSigned, resultmsub;
	reg [65:0]resultUnsigned, remainUnsigned;//λ������������
	reg [2:0]Optemp;
									
	always @(posedge Clk) begin
		if (Start === 1) begin//��ʼ����
			Busy = 1;
			Optemp = Op;
			resultSignedM = $signed(D1) * $signed(D2) ;//////////////////////////////////////////////$signed(D1)�п��ܳ���Ŷ����������˾�����߶���������always��߸�ֵ
			resultSignedD = $signed(D1) / $signed(D2) ;
			resultUnsigned = Optemp === 2'b01 ? {1'b0, D1} * {1'b0, D2} : 
								  Optemp === 2'b11 ? {1'b0, D1} / {1'b0, D2} :
								  66'bx;
			remainSigned = $signed(D1) % $signed(D2) ;
			remainUnsigned = {1'b0, D1} % {1'b0, D2} ;/////////////////////////////////////////////////
			resultmsub = $signed({dataHi, dataLo}) - resultSignedM;
			/*if(Op === 2'b00 || Op === 2'b01) begin
				;
			end*/
			if(Optemp === 3'b00 || Optemp ===  3'b01 || Optemp === 3'b100) mulCount = mulCount - 1;
			if(Optemp === 3'b10 || Optemp ===  3'b11) divCount = divCount - 1;
		end
		else if(Busy === 1)begin//æµ�źţ����еĹ��ڳ˳������ź�ͳͳ��ͣ
			if (Optemp === 3'b00 || Optemp ===  3'b01 || Optemp ===  3'b100) mulCount = mulCount - 1;
			if(Optemp === 3'b10 || Optemp ===  3'b11) divCount = divCount - 1;
		end
		if (mulCount === 0 || divCount === 0)begin//�Ƿ����///////////////////////////////////////
			dataHi = (Optemp === 3'b00) ? resultSignedM[63:32] :
						(Optemp === 3'b10) ? remainSigned :
						(Optemp === 3'b01) ? resultUnsigned[63:32] :
						(Optemp === 3'b11) ? remainUnsigned : 
						(Optemp === 3'b100) ? resultmsub[63:32] :
						32'bx;
			dataLo = (Optemp === 3'b00) ? resultSignedM[31:0] :
						(Optemp === 3'b10) ? resultSignedD[31:0] :
						(Optemp === 3'b01) ? resultUnsigned[31:0] :
						(Optemp === 3'b11) ? resultUnsigned[31:0] :
						(Optemp === 3'b100) ? resultmsub[31:0] :
						32'bx;/////////////////////////////////////////////////////////////////////////////////////
			Busy = 0;
			if(Optemp === 3'b00 || Optemp ===  3'b01 || Optemp ===  3'b100) mulCount = 5;
			if(Optemp === 3'b10 || Optemp ===  3'b11) divCount = 10;
			Optemp = 2'b0;
		end
		//mtlo, mthi
		if(We === 1) begin
			if(HiLo === 1) begin
				dataHi = D1;
			end
			else if(HiLo === 0) begin
				dataLo = D1;
			end
		end
	end
	assign HI = dataHi;
	assign LO = dataLo;
endmodule
