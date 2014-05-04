`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:59:33 12/06/2013 
// Design Name: 
// Module Name:    Reg_B_Mux 
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
module Reg_B_Mux(ALUSrcB,Reg_B_Out,SZSE_Out,Out);
input [31:0] Reg_B_Out,SZSE_Out;
input [1:0] ALUSrcB;
output reg [31:0] Out;

always @ (*)
begin
    if(ALUSrcB == 0)
        Out <= Reg_B_Out;
		  
    else if(ALUSrcB == 1)
        Out <= 1;

    else
        Out <= SZSE_Out;
end
endmodule