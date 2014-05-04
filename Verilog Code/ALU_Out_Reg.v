`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:07:19 12/06/2013 
// Design Name: 
// Module Name:    ALU_Out_Reg 
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
module ALU_Out_Reg(ALUResult,Clk,Reset,Result);
input [31:0] ALUResult;
input Clk,Reset;
output reg [31:0] Result;

always @ (posedge Clk)
begin
    if(Reset)
        Result <= 32'b0;

    else
        Result <= ALUResult;
end
endmodule