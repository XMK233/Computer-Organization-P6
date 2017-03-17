`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:35:47 11/23/2015 
// Design Name: 
// Module Name:    ctrl 
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
module Controller(
    input [31:0]Instruction,
	 //
    output RegWriteD,//w
    output MemtoRegD,
    output MemWriteD,//m
    output [4:0]ALUCtrlD,//ex
    output ALUSrcD,
    output RegDstD,
	 output [2:0]AndLink,
    output JumpToTargetD,//?
	 output JumpAndLinkD,
	 output JumpRegD,
	 output JumpAndLinkRegD,
	 /*output BgtzD,
	 output BeqD,
	 output BgezalD,*/
	 output [2:0]Ls,
	 output [1:0]Ss,
	 //乘除类别
	 output [2:0]MDOp,//乘除符号
	 output HiLo,
	 output Start,
	 output MDWe,
	 output MDOutFin,//选择hi还是lo作为rd输入值
	 output MDSignal
    );
	wire fcAddu, fcSubu, fcbgtz, fcjr,fcAdd,fcbgezal, fcsll, fcsrl, fcsra, fcsllv, fcsrlv, fcsrav;
	wire fcand, fcor,fcxor, fcnor;
	wire addu, addiu, andi, xori, subu, sub, add, ori, lui, j, jal,jr, jalr, addi,bgezal;
	wire beq;
	wire sll, srl, sra, sllv, srlv, srav;
	wire slt, slti, sltiu, sltu;
	wire And, Or, Xor, Nor;
	wire lb, lbu, lh, lhu;
	wire sb, sh;
	wire [5:0]func,op;
	wire mflo, mfhi, mtlo, mthi, mult, multu, div, divu;
	wire lw, sw;
	wire msub;
	
	assign func = Instruction[5:0];
	assign op = Instruction[31:26];
	//
	assign fcAddu = (func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & func[0]);
	assign fcSubu = (func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & func[0]);
	assign fcAdd = (func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0]);
	assign fcbgtz = (~Instruction[20] & ~Instruction[19] & ~Instruction[18] & ~Instruction[17] & ~Instruction[16]);
	assign fcjr = (~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & ~func[0]);
	assign fcbgezal = (Instruction[20] & ~Instruction[19] & ~Instruction[18] & ~Instruction[17] & Instruction[16]);
	assign fcsll = (~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0]);
	assign fcsrl = (~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0]);
	assign fcsra = (~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & func[0]);
	assign fcsllv = (~func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0]);
	assign fcsrlv = (~func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0]);
	assign fcsrav = (~func[5] & ~func[4] & ~func[3] & func[2] & func[1] & func[0]);
	
	//
	assign addu = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcAddu);
	assign subu = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcSubu);
	assign add = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcAdd);
	assign lui = (~op[5] & ~op[4] & op[3] & op[2] & op[1] & op[0]);
	assign j = (~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0]);
	assign jal = (~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0]);
	assign ori = (~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & op[0]);
	assign lw = (op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0]);
	assign sw = (op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0]);
	assign addi = (~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & ~op[0] );
	assign bgtz = (~op[5] & ~op[4] & ~op[3] & op[2] & op[1] & op[0] & fcbgtz);
	assign beq = (~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0]);
	assign jr = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcjr);
	assign jalr = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & func[0]);
	assign bgezal = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0] & fcbgezal);
	assign lb = (op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]);
	assign lbu = (op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0]);
	assign lh = (op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0]);
	assign lhu = (op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0]);
	assign sb = (op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & ~op[0]);
	assign sh = (op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & op[0]);///////////////////
	assign sll = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcsll & (Instruction !== 32'b0));
	assign srl = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcsrl);
	assign sra = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcsra);
	assign sllv = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcsllv);
	assign srlv = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcsrlv);
	assign srav = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & fcsrav);
	assign And = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0]);
	assign Or = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & func[0]);
	assign Xor = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0]);
	assign Nor = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & func[0]);
	assign addiu = (~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & op[0]);
	assign andi = (~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & ~op[0]);
	assign xori = (~op[5] & ~op[4] & op[3] & op[2] & op[1] & ~op[0]);
	assign slt = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & ~func[0]);
	assign sltu = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & func[0]);
	assign slti = (~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & ~op[0]);
	assign sltiu = (~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0]);
	assign mfhi = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0]);
	assign mflo = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & ~func[3] & ~func[2] & func[1] & ~func[0]);
	assign mthi = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & ~func[3] & ~func[2] & ~func[1] & func[0]);
	assign mtlo = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & ~func[3] & ~func[2] & func[1] & func[0]);
	assign mult = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & func[3] & ~func[2] & ~func[1] & ~func[0]);
	assign multu = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & func[3] & ~func[2] & ~func[1] & func[0]);
	assign div = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & func[3] & ~func[2] & func[1] & ~func[0]);
	assign divu = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] & func[4] & func[3] & ~func[2] & func[1] & func[0]);
	assign sub = (~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0]);
	assign msub = (~op[5] & op[4] & op[3] & op[2] & ~op[1] & ~op[0] & ~func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0]);
	//
	assign RegDstD = addu | subu | add | sub | sll | srl | sra | sllv | srlv | srav | And | Or | Xor | Nor |
						  slt | sltu | jalr | mflo | mfhi;
	assign ALUSrcD = ori | lui | addi | sw | sb | sh | lw | lb | lbu | lh | lhu | addiu | andi | xori |
						  slti | sltiu;
	assign MemtoRegD = lw | lb | lbu | lh | lhu; 
	assign RegWriteD = addu | add | subu | sub | ori | lw | lui | addi | lb | lbu | lh | lhu | sll | srl | sra | sllv | srlv | srav |
							 And | Or | Xor | Nor | addiu | andi | xori | slt | sltu | slti | sltiu |
							 jalr | jal | bgezal | mflo | mfhi;
	assign MemWriteD = sw | sb | sh;
	assign Add = addu | add | sw | sb | sh | lw | addi | lb | lbu | lh | lhu | addiu; 
	assign Subtract = subu | sub;
	assign ALUCtrlD = (Add) ? 5'b000 : 
							(Subtract)? 5'b001 : 
							(ori) ? 5'b010 : 
							(lui) ? 5'b011 : 
							(sll) ? 5'b00100 : 
							(srl) ? 5'b00101 :
							(sra) ? 5'b00110 :
							(sllv) ? 5'b00111 :
							(srlv) ? 5'b01000 :
							(srav) ? 5'b01001 :
							(And || andi) ? 5'b01010 :
							(Or) ? 5'b01011 :
							(Xor) ? 5'b01100 :
							(Nor) ? 5'b01101 :
							(slt || slti) ? 5'b01110: 
							(sltu || sltiu) ? 5'b01111 :
							(xori) ? 5'b10000 :
							3'bx;
	assign JumpToTargetD = j;
	assign JumpAndLinkD = jal;
	assign JumpRegD = jr;
	assign JumpAndLinkRegD = jalr;
	/*assign BgtzD = bgtz;
	assign BeqD = beq;
	assign BgezalD = bgezal;*/
	assign Ls = (lb === 1) ? 3'b001 :
					(lbu === 1) ? 3'b010 :
					(lh === 1) ? 3'b011 : 
					(lhu === 1) ? 3'b100 : 
					3'b0;
	assign Ss = (sb === 1) ? 2'b01 : 
					(sh === 1) ? 2'b10 :
					(sw === 1) ? 2'b11 :
					3'b0;
	assign AndLink = (jal) ? 3'b001: 
						  (bgezal) ? 3'b010:
						  (jalr) ? 3'b011:
						  3'b0;
	//乘除单元信号	
	assign MDOp = (mult) ? 3'b00 : 
					  (multu) ? 3'b01 : 
					  (div) ? 3'b10 : 
					  (divu) ? 3'b11 : 
					  (msub) ? 3'b100 :
					  3'bx;
	assign HiLo = (mthi === 1) ? 1 :
					  (mtlo === 1) ? 0 :
					  1'bx;
	assign Start = (MDOp !== 3'bx) ? 1 : 0;
	assign MDWe = mtlo | mthi;
	assign MDOutFin = (mfhi) ? 1 :
							(mflo) ? 0 :
							1'bx;
	assign MDSignal = mflo | mfhi | mtlo | mthi | mult | multu | div | divu | msub; 
endmodule
