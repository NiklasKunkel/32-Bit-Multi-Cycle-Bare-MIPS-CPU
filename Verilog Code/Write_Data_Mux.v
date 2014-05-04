`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:24:26 12/06/2013 
// Design Name: 
// Module Name:    Write_Data_Mux 
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
module Write_Data_Mux(MemToReg,ALU_Out,Mem_Data_Reg,Write_Data);
input [31:0] ALU_Out, Mem_Data_Reg;
input MemToReg;
output reg [31:0] Write_Data;

always @ (*)
    if(MemToReg == 0)
	 begin
        Write_Data <= ALU_Out;
	 end
    else
	 begin
        Write_Data <= Mem_Data_Reg;
	 end
endmodule