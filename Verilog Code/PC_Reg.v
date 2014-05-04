`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:48:52 12/06/2013 
// Design Name: 
// Module Name:    PC_Reg 
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
module PC_Reg(PC_Out,PC_In,PCWrite,CLK,Reset);

output	reg	[31:0]	PC_Out;
input	[31:0]	PC_In;
input	PCWrite,CLK,Reset;

initial begin
PC_Out = 0;
end

always @ (posedge CLK)
begin
	if(Reset == 1'b1)
		PC_Out <= 0;

	if(PCWrite == 1'b1)
		PC_Out <= PC_In;
end
endmodule
