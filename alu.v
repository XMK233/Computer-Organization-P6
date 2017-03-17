`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:17:12 11/23/2015 
// Design Name: 
// Module Name:    alu 
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
module ALU(
    input signed [31:0]A,
    input signed [31:0]B,
    input [4:0]Op,
    output [31:0]C,
    output Over//Òç³ö
    );
	 /*reg signed [32:0]i = {1'b0, A};
	 reg signed [32:0]j = {1'b0, B};
	 always @(*) begin
		case (Op)
			(5'b00) :  C = A + B ; 
						 (5'b01) : C = A - B ; 
						 (5'b10) :  C = A | B ; 
						 (5'b11) :  C = B<<16 ; 
						 (5'b00100) :  C = A<<B ; 
						 (5'b00111) :  C = B<<A ;
						 (5'b00101) :  C = A>>B ;
						 (5'b01000) :  C = B>>A ; 
						 (5'b00110) :  C = A>>>B ; 
						 (5'b01001) :  C = B>>>A ;
						 (5'b01010) : C =  A & B ;
						 (5'b01011) :  C = A | B ;
						 (5'b01100) :  C = A ^ B ;
						 (5'b01101) : C =  ~(A | B) ;
						 (5'b01110 && A < B) :  C = 32'b1 ;
						 (5'b01110 && A >= B) :  C = 32'b0 ;
						 (5'b01111 && i < j) :  C = 32'b1 ;
						 (5'b01111 && i >= j) :  C = 32'b0 ;
						 default : C = 32'bx; 
		endcase
	 end*/
	wire signed [32:0]i = {1'b0, A};
	 wire signed [32:0]j = {1'b0, B};
	assign C = (Op === 5'b00) ? A + B : 
						 (Op === 5'b01) ? A - B : 
						 (Op === 5'b10) ? A | B : 
						 (Op === 5'b11) ? B<<16 : 
						 (Op === 5'b00100) ? A<<B : 
						 (Op === 5'b00111) ? B<<A :
						 (Op === 5'b00101) ? A>>B :
						 (Op === 5'b01000) ? B>>A : 
						 (Op === 5'b00110) ? {{31{A[31]}}, A} >> B : 
						 (Op === 5'b01001) ? {{31{B[31]}}, B} >> A :
						 (Op === 5'b01010) ? A & B :
						 (Op === 5'b01011) ? A | B :
						 (Op === 5'b01100) ? A ^ B :
						 (Op === 5'b01101) ? ~(A | B) :
						 (Op === 5'b01110 && A < B) ? 32'b1 :
						 (Op === 5'b01110 && A >= B) ? 32'b0 :
						 (Op === 5'b01111 && i < j) ? 32'b1 :
						 (Op === 5'b01111 && i >= j) ? 32'b0 :
						 (Op === 5'b10000) ?  A ^ B:
						 32'bx; 
	assign Over = (C === 32'b0) ? 1 : 0;//
endmodule
