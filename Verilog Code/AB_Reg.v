`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:47:14 12/06/2013 
// Design Name: 
// Module Name:    AB_Reg 
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
module AB_Reg(Read_Data1,CLK,Reset,Reg_AB_Out);
input [31:0] Read_Data1;
input CLK,Reset;
output reg [31:0] Reg_AB_Out;

always @ (posedge CLK)
begin
    if(Reset)
        Reg_AB_Out <= 0;
    else
        Reg_AB_Out <= Read_Data1;
end
endmodule