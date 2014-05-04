`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:12:33 12/06/2013 
// Design Name: 
// Module Name:    Instruction_Register 
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
module Instruction_Register(Instruction,IRWrite,Clk,Reset,Instr31_26,Instr25_21,Instr20_16,Instr15_0);
input [31:0] Instruction;
input Clk,Reset,IRWrite;
output reg [5:0] Instr31_26;
output reg [4:0] Instr25_21,Instr20_16;
output reg [15:0] Instr15_0;

always @ (posedge Clk or posedge Reset)
    if(Reset)
    begin
        Instr31_26 <= 0;
        Instr25_21 <= 0;
        Instr20_16 <= 0;
        Instr15_0 <= 0;
    end
    else if(IRWrite==1'b1)
    begin
        Instr31_26 <= Instruction [31:26];
        Instr25_21 <= Instruction [25:21];
        Instr20_16 <= Instruction [20:16];
        Instr15_0 <= Instruction [15:0];
    end
endmodule