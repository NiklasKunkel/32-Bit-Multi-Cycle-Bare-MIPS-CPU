`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:22:53 12/06/2013 
// Design Name: 
// Module Name:    Write_Reg_Mux 
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
module Write_Reg_Mux(RegDst,Instr25_21,Instr15_11,Write_Reg);
input [4:0] Instr25_21,Instr15_11;
input [1:0]	RegDst;
output reg [4:0] Write_Reg;

always @(*)
begin
	if(RegDst == 2'b00)
		begin
		Write_Reg <= Instr25_21;
		end
		
	else if(RegDst == 2'b10)
		begin
		Write_Reg <= 5'b11111;
		end
		
	else
		begin
		Write_Reg <= Instr15_11;
		end
end
endmodule