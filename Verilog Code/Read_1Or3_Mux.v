`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:30:17 12/06/2013 
// Design Name: 
// Module Name:    Read_1Or3_Mux 
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
module Read_1Or3_Mux(Read1or3,Instr25_21,Instr15_11,ReadReg1);
input [4:0] Instr25_21,Instr15_11;
input Read1or3;
output reg [4:0] ReadReg1;

always @(*)
begin
    if(Read1or3 == 0)
        ReadReg1 <= Instr25_21;
    else
        ReadReg1 <= Instr15_11;
end
endmodule