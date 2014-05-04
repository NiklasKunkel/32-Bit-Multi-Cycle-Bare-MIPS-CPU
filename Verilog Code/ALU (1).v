`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:10:28 12/06/2013 
// Design Name: 
// Module Name:    ALU 
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
module ALU(Reg_A,Reg_B,ALUOp,Reset,BorN,Branch_Flag,ALU_Out);
input [31:0] Reg_A, Reg_B;
input [2:0] ALUOp;
input [1:0] BorN;
input Reset;
output reg Branch_Flag;
output reg [31:0] ALU_Out;
reg [31:0] MOV,NOT,ADD,SUB,OR,AND,XOR,SLT;

always @ (*)
begin
	if(Reset == 1)
		ALU_Out <= 32'b0;

	else
	begin
		MOV = Reg_B;
		NOT = ~Reg_B;
		ADD = Reg_B + Reg_A;
		SUB = Reg_B - Reg_A;
		OR = (Reg_A | Reg_B);
		AND = (Reg_A & Reg_B);
		XOR = Reg_A ^ Reg_B;
		
		if(Reg_A >= Reg_B)
			SLT = 32'b1;

		else
			SLT = 32'b0;

		if(BorN == 2'b00)
		begin
			if(Reg_A == Reg_B)
					Branch_Flag <= 1'b1;
			else
				Branch_Flag <= 1'b0;
		end
		
		if(BorN == 2'b01)
		begin
			if(Reg_A != Reg_B)
					Branch_Flag <= 1'b1;					
			else
				Branch_Flag <= 1'b0;
		end
		
		if(BorN == 2'b10)
		begin
			if(Reg_A < Reg_B)
					Branch_Flag <= 1'b1;					
			else
				Branch_Flag <= 1'b0;
		end
		
		if(BorN == 2'b11)
		begin
			if(Reg_A <= Reg_B)
					Branch_Flag <= 1'b1;
			else
				Branch_Flag <= 1'b0;
		end
        
		case (ALUOp)
			0: ALU_Out <= MOV;
			1: ALU_Out <= NOT;
			2: ALU_Out <= ADD;
			3: ALU_Out <= SUB;
			4: ALU_Out <= OR;
			5: ALU_Out <= AND;
			6: ALU_Out <= XOR;
			7: ALU_Out <= SLT;
		endcase
	end
end
endmodule
