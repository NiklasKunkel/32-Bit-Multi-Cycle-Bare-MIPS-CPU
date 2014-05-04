`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:14:55 12/06/2013
// Design Name:   Datapath
// Module Name:   /ad/eng/users/n/k/nkunkel/CompOrgLab/Project/ProjectNew/Test.v
// Project Name:  ProjectNew
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test;
	
	//Inputs
	reg CLK;
	reg Reset;

	// Instantiate the Unit Under Test (UUT)
	Datapath uut (
		.CLK(CLK),
		.Reset(Reset)
	);
	
	always #2 CLK = ~CLK;
	
	initial begin
		// Initialize Inputs
		CLK = 0;
		Reset = 1;
		
		// Wait 100 ns for global reset to finish
		#20;
		Reset = 0;
        
		// Add stimulus here

	end
      
endmodule

