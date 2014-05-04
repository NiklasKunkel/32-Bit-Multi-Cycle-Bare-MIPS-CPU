`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:18:22 12/06/2013 
// Design Name: 
// Module Name:    Sign_Logical_Extend 
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
module Sign_Logical_Extend(ZorS,Instr15_0,SZSE_Out);
input [15:0] Instr15_0;
input [1:0] ZorS;
output reg [31:0] SZSE_Out;

always @(*)
begin
    if(ZorS == 0)
	 begin
        if(Instr15_0[15] == 2'b00)
            SZSE_Out <= {16'b0000000000000000,Instr15_0};
        else
            SZSE_Out <= {16'b1111111111111111,Instr15_0};
	 end
	 
    else if(ZorS == 2'b01)
        SZSE_Out <= {16'b0000000000000000,Instr15_0};

    else if(ZorS == 2'b10)
		SZSE_Out <= {Instr15_0,16'b0000000000000000};

	 else
        SZSE_Out <= {14'b00000000000000,Instr15_0,2'b00};
end
endmodule