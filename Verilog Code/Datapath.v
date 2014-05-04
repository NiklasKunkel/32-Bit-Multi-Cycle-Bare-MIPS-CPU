`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:23:53 12/06/2013 
// Design Name: 
// Module Name:    Datapath 
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
module Datapath(CLK,Reset);
	
input CLK,Reset;
wire [31:0] Instruction,PC_Out,PCW,MemData,ALU_Reg_Out,Mem_Data_Reg_Out,Read_Data1,Read_Data2,Reg_A_Out,Reg_B_Out,RAMO,RBMO;
wire [31:0] SZSE_Out,Result,Write_Data;
wire [15:0] Instr15_0;
wire [5:0] Instr31_26;
wire [4:0] Instr25_21,Instr20_16,Write_Reg,ReadReg1,R1O3_Out;
wire [2:0] ALUOp,ALUSrcA;
wire [1:0] PC_Source,ALUSrcB,ZorS,RegDst,BorN;
wire PCWrite,MemWrite,IRWrite,MemToReg,Zero,PCWriteCond,PCWriteEnable,BOC,RegWrite,Read1or3;






PC_Reg PCREG (PC_Out,PCW,PCWriteEnable,CLK,Reset);
IMem Memory (PC_Out,Instruction);
DMem Data (Reg_A_Out,MemData,ALU_Reg_Out,MemWrite,CLK);
Mem_Data_Reg MemReg (Mem_Data_Reg_Out,MemData,CLK,Reset);
Instruction_Register IReg (Instruction,IRWrite,CLK,Reset,Instr31_26,Instr25_21,Instr20_16,Instr15_0);

Logic_Controller Controller(ALUOp,ALUSrcA,PC_Source,ALUSrcB,BorN,ZorS,RegDst,PCWriteCond,PCWrite,RegWrite,IRWrite,MemWrite,MemToReg,Read1or3,Instr31_26,CLK,Reset);

Write_Reg_Mux WRMux (RegDst,Instr25_21,Instr15_0[15:11],Write_Reg);
Read_1Or3_Mux R1O3 (Read1or3,Instr25_21,Instr15_0[15:11],ReadReg1);
Write_Data_Mux WDMux (MemToReg,ALU_Reg_Out,Mem_Data_Reg_Out,Write_Data);

Gen_Purpose_Reg GPR (RegWrite,CLK,ReadReg1,Instr20_16,Write_Reg,Write_Data,Read_Data1,Read_Data2);
AB_Reg RegA (Read_Data1,CLK,Reset,Reg_A_Out);
AB_Reg RegB (Read_Data2,CLK,Reset,Reg_B_Out);
Reg_A_Mux RAMux (ALUSrcA,PC_Out,Reg_A_Out,SZSE_Out,Reg_B_Out,RAMO);
Reg_B_Mux RBMux (ALUSrcB,Reg_B_Out,SZSE_Out,RBMO);
ALU Alu (RAMO,RBMO,ALUOp,Reset,BorN,Zero,Result);
ALU_Out_Reg AluOut (Result,CLK,Reset,ALU_Reg_Out);
PC_Mux PCMux (PC_Source,Result,ALU_Reg_Out,{PC_Out[31:26],Instr25_21,Instr20_16,Instr15_0},PCW);
Sign_Logical_Extend SZSE (ZorS,Instr15_0,SZSE_Out);

assign PCWriteEnable = (PCWriteCond & Zero) | PCWrite;

endmodule
