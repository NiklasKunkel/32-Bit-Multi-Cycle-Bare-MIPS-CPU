`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:58:06 12/06/2013 
// Design Name: 
// Module Name:    Reg_A_Mux 
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
module Reg_A_Mux(ALUSrcA,PCCount,Reg_A_Out,SZSE_Out,Reg_B_Out,Out);
input [31:0] PCCount, Reg_A_Out,SZSE_Out,Reg_B_Out;
input [2:0]ALUSrcA;
output reg [31:0] Out;

always @(*)
begin
    if(ALUSrcA == 0)
        Out <= PCCount;

    else if(ALUSrcA == 1)
        Out <= Reg_A_Out;

	 else if(ALUSrcA == 2)
		Out <= 32'b0;
		
	 else if(ALUSrcA == 3)
		Out <= SZSE_Out;
		
	 else
		Out <= Reg_B_Out;
end
endmodule