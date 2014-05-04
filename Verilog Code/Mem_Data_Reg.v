`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:07:41 12/06/2013 
// Design Name: 
// Module Name:    Mem_Data_Reg 
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
module Mem_Data_Reg(Data_Out,Data_In,CLK,Reset);
output reg [31:0] Data_Out;
input [31:0] Data_In;
input CLK,Reset;


always @ (posedge CLK)
begin
    if(Reset)
       Data_Out <= 0;
    else
        Data_Out <= Data_In;
end
endmodule
