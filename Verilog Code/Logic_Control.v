`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:11:40 11/15/2013 
// Design Name: 
// Module Name:    Logic_Controller 
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
module Logic_Controller(
	ALUOp,
	ALUSrcA,
	PCSource,
	ALUSrcB,
	BorN,
	ZorS,
	RegDst,
	PCWriteCond,
	PCWrite,
	RegWrite,
	IRWrite,
	MemWrite,
	MemToReg,
	Read1or3,
	Opcode,
	CLK,
	Reset	
    );
	 
output	reg	[2:0]	ALUOp, ALUSrcA;
output	reg	[1:0]	PCSource,ALUSrcB,BorN,ZorS, RegDst;
output	reg	PCWriteCond, PCWrite, RegWrite, IRWrite, MemWrite, MemToReg, Read1or3;

input	[5:0]	Opcode;
input	CLK,Reset;

reg	[3:0]	state, next_state;

//ALUOp Values:
// 00 -> addition
// 01 -> subtraction
// 10 -> Function (R-Type)
// 11 -> Opcode	(I-Type)


///////////////////////
//STATES///////////////
///////////////////////

	parameter S0 = 4'b0000; //Instruction Fetch
	parameter S1 = 4'b0001; //Instruction Decode
	parameter S2 = 4'b0010;
	parameter S3 = 4'b0011;
	parameter S4 = 4'b0100;
	parameter S5 = 4'b0101;
	parameter S6 = 4'b0110;
	parameter S7 = 4'b0111;
	parameter S8 = 4'b1000;
	parameter S9 = 4'b1001;  //Memory Write	
	parameter S10 = 4'b1010; //Register Write
	parameter S11 = 4'b1011;
	parameter S12 = 4'b1100;
	parameter S13 = 4'b1101;
	parameter S14 = 4'b1110;


//Sequential Logic Synced to Clock

always @(posedge CLK)
begin
	state <= next_state;
end


always @ (state or Reset)
begin
	if(Reset == 1'b1)
		begin
		next_state = S0;
		PCSource = 2'b00;
      ALUOp = 3'b000;
      ALUSrcB = 2'b00;
      ALUSrcA = 3'b000;
      RegWrite = 1'b1;
      RegDst = 1'b00;
      IRWrite = 1'b0;
      MemToReg = 1'b0;
      MemWrite = 1'b0;
      PCWrite = 1'b0;
      PCWriteCond = 1'b0;
		BorN = 2'b00;
		
		Read1or3 = 1'b0;
		ZorS = 2'b00;
		end
	
	else
	begin
		
	case(state)
	
		//Instruction Fetch
		S0:
		begin 	
			//Reset Controller Values
			ALUSrcA = 3'b000;
			MemWrite = 1'b0;
			RegWrite = 1'b0;
			PCWrite = 1'b1;
			PCSource = 2'b00;
			PCWriteCond = 1'b0;
			BorN = 2'b00;
			IRWrite = 1'b1;
			ALUOp = 3'b010;
			MemToReg = 1'b0;
			ALUSrcB = 2'b01;
			RegDst = 1'b00;
			Read1or3 = 1'b0;
			ZorS = 2'b00;
			next_state = S1;
		end
		
		//Instruction Decode
		S1:
		begin
			IRWrite = 1'b0;
			PCWrite = 1'b0;
			ALUSrcA = 3'b000;
			ALUSrcB = 2'b10;
			ALUOp = 3'b010;
			Read1or3 = 1'b0;
			
			//JUMP & JAL
			if(Opcode[5:4] == 2'b00)
				begin
					//JAL
					if(Opcode [1:0] == 2'b11)
						begin
						ALUSrcB = 2'b01;
						next_state = S14;
						end
					//J
					else
						next_state = S11;
				end
				
			//R-Type
			else if(Opcode[5:4] == 2'b01)
				begin
					Read1or3 = 1'b1;
					next_state = S6;
				end
			
			
			//Branch Type
			else if(Opcode[5:4] == 2'b10)
				begin
					next_state = S10;
				end
			
			//I-Type
			else if(Opcode[5:4] == 2'b11)
				begin
					//LWI/SWI/LI/LUI/SW/LW
					if(Opcode[3] == 1'b1)
					begin
						//SW
						if(Opcode [2:0] == 3'b110)
							next_state = S12;
						//LWI/SWI/LI/LUI/LW
						else
							next_state = S2;
					end
					
					//I Type Logical/Arithmetic
					else
						next_state = S8;
				end
			end
		
		//Execution: LWI SWI LI LUI
		S2:
		begin
			//LI
			if(Opcode[2:0]	== 2'b001)
				begin
				ALUSrcA = 3'b010;
				ALUSrcB = 2'b10;
				ALUOp = 3'b100;
				end
			//LW
			else if(Opcode[2:0] == 3'b101)
				begin
				ALUSrcA = 3'b011;
				ALUSrcB = 2'b00;
				ALUOp = 3'b010;
				end
			//LUI	
			else if(Opcode[1:0]	== 2'b10)
				begin
				ALUSrcA = 3'b001;
				ALUSrcB = 2'b10;
				ALUOp = 3'b100;
				end
			//SWI & LWI
			else if(Opcode[1:0] == 2'b00 || Opcode[1:0] == 2'b11)
				begin
				ALUSrcA = 3'b010;
				ALUSrcB = 2'b10;
				ALUOp = 3'b100;
				end
				
			if(Opcode[2:0]	== 3'b101)
				next_state = S3;
			
			//LI/LUI/LWI/LW
			else if(Opcode[2] == 1'b0)
				next_state = S3;
			//SWI
			else
				next_state = S5;
		end
			
		//Execution: LWI/LI/LUI
		S3:
		begin
			if(Opcode [2:0]	== 3'b101)
				next_state = S4;
		
			//LI
			else if(Opcode[2:1] == 2'b00)
				begin
				ZorS = 2'b01;
				next_state = S4;
				end
				
			//LWI/LUI	
			else
				begin
				ZorS = 2'b10;
				next_state = S4;
				end
		end
		
		//LWI/LUI/LI Completion
		S4:
		begin
			if(Opcode [2:0] == 3'b101)
				begin
				RegDst = 2'b00;
				RegWrite = 1'b1;
				MemToReg = 1'b1;
				next_state = S0;	
				end
		
			//LWI
			if(Opcode[1:0] == 2'b11)
				begin
				RegDst = 2'b00;
				RegWrite = 1'b1;
				MemToReg = 1'b1;
				next_state = S0;
				end
			
			//LI/LUI
			else
				begin
				RegDst = 2'b00;
				RegWrite = 1'b1;
				MemToReg = 1'b0;
				next_state = S0;
				end
		end
		
		//SWI
		S5:
		begin
			MemWrite = 1'b1;
			ZorS = 2'b01;
			next_state = S0;
		end
			
		//Execution: R-Type
		S6:
		begin    
			Read1or3 = 1'b0;
			ALUSrcA = 3'b001;
		   ALUSrcB = 2'b00;
		   next_state = S7;
			
			//MOV
			if(Opcode[2:0] == 3'b000)
				ALUOp = 3'b000;
			
			//NOT
			else if(Opcode[2:0] == 3'b001)
				ALUOp = 3'b001;
				
			//ADD	
			else if(Opcode[2:0] == 3'b010)
             ALUOp = 3'b010;
			
			//SUB
			else if(Opcode[2:0] == 3'b011)
             ALUOp = 3'b011;
			
			//OR
			else if(Opcode[2:0] == 3'b100)
             ALUOp = 3'b100;
			
			//AND
			else if(Opcode[2:0] == 3'b101)
             ALUOp = 3'b101;
			
			//XOR
			else if(Opcode[2:0] == 3'b110)
             ALUOp = 3'b110;
			
			//SLT
			else if(Opcode[2:0] == 3'b111)
             ALUOp = 3'b111;
		end
	
		//R-Type Completion
		S7:
			begin
			RegDst = 2'b00;
			RegWrite = 1'b1;
			MemToReg = 1'b0;
			next_state = S0;
			end
		
		//I Type
		S8:
		begin
			next_state = S9;
			
			//ADDI
			if(Opcode[2:0] == 3'b010)
				begin
				ALUSrcA = 3'b100;
				ALUSrcB = 2'b10;
				ALUOp = 3'b010;
				ZorS = 2'b00;
				end
			
			//SUBI
			else if(Opcode[2:0] == 3'b011)
				begin
				ALUSrcA = 3'b011; //This Value is Wrong
				ALUSrcB = 2'b10;
				ALUOp = 3'b100;
				ZorS = 2'b00;
				end
			
			//ORI
			else if(Opcode[2:0] == 3'b100)
				begin
				ALUSrcA = 3'b011;
				ALUSrcB = 2'b10;
				ALUOp = 3'b100;
				ZorS = 2'b01;
				end
			
			//ANDI
			else if(Opcode[2:0] == 3'b101)
				begin
				ALUSrcA = 3'b100;
				ALUSrcB = 2'b10;
				ALUOp = 3'b101;
				ZorS = 2'b01;
				end
			
			//XORI
			else if(Opcode[2:0] == 3'b0110)
				begin
				ALUSrcA = 3'b100;
				ALUSrcB = 2'b10;
				ALUOp = 3'b110;
				ZorS = 2'b01;
				end
				
			//SLTI
			else if(Opcode[2:0] == 3'b111)
				begin
				ALUSrcA = 3'b100;
				ALUSrcB = 2'b10;
				ALUOp = 3'b111;
				ZorS = 2'b00;
				end
		end

		//I-Type Completion
		S9:
		begin
			RegWrite = 1'b1;
			RegDst = 2'b00;
			MemToReg = 1'b0;
			next_state = S0;
		end
	
		//Write Back - I-Type
		S10:
		begin
			PCSource = 2'b01;
			PCWriteCond = 1'b1;
			ALUSrcA = 3'b001;
			ALUSrcB = 2'b00;
			ZorS = 2'b00;
			next_state = S0;
			
			//BEQ
			if(Opcode[3:0] == 4'b0000)
				begin
				ALUOp = 3'b011;
				BorN = 2'b00;
				end
				
			//BNE
			else if(Opcode[3:0] == 4'b0001)
				begin
				ALUOp = 3'b011;
				BorN = 2'b01;
				end
			
			//BLT
			else if(Opcode[3:0] == 4'b0010)
				begin
				ALUOp = 3'b111;
				BorN = 2'b10;
				end
			
			//BLE
			else if(Opcode[3:0] == 4'b0011)
				begin
				ALUOp = 3'b111;
				BorN = 2'b11;
				end
		end
			
		//JUMP & NOOP
		S11:
		begin
			
			//NOOP
			if(Opcode[3:0] == 0000)
				next_state = S0;
				
			//JUMP
			else
				begin
					PCSource = 2'b10;
					PCWrite = 1'b1;
					next_state = S0;
				end
		end
		
		S12:
		begin
			ALUSrcA = 3'b001;
			ALUSrcB = 2'b10;
			ALUOp = 3'b010;
			ZorS = 2'b00;
			next_state = S13;
		end
		
		S13:
		begin
			MemWrite = 1'b1;
			next_state = S0;
		end
		
		S14:
		begin
			PCSource = 2'b10;
			PCWrite = 1'b1;
			RegDst = 2'b10;
			MemToRg = 1'b0;
			RegWrite = 1'b1;
			next_state = S0;
		end
			
	endcase
	end
end


endmodule