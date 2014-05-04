`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:01:06 12/06/2013 
// Design Name: 
// Module Name:    PC_Mux 
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
module PC_Mux(PC_Source,ALUResult,ALUOut,Jump,PC);
input [31:0] ALUResult,ALUOut,Jump;
input [1:0] PC_Source;
output reg [31:0] PC;

always @(*)
begin
    if(PC_Source == 0)
         PC <= ALUResult;

    else if(PC_Source == 1)
         PC <= ALUOut;

    else
         PC <= Jump;
end
endmodule