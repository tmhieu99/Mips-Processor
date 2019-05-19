module control(Opcode, funct, Jump, Branch, MemRead, MemWrite, 
Mem2Reg, ALUop, Exception, ALUsrc, RegWrite, RegDst, ALU_control);
	input [5:0] Opcode, funct;
	output reg  Jump,			//10 
					Branch,		//9 
					MemRead,		//8 
					MemWrite,	//7 
					Mem2Reg,		//6 		//54 
					Exception,	//3 
					ALUsrc, 		//2
					RegWrite,	//1 
					RegDst;	
	output reg [1:0] ALUop;
	output reg [3:0] ALU_control;
always@(Opcode , funct) 
	begin
		case(Opcode)
				// R format
				6'b 000000: begin 
					Jump			<=	0; 
					Branch		<= 0; 
					MemRead		<= 0; 
					MemWrite		<= 0;
					Mem2Reg		<= 0;
					ALUop			<=	2'b10; 
					Exception	<= 0; 
					ALUsrc		<= 0;
					RegWrite		<= 1;
					RegDst		<= 1;
					//ALUCtrl ALUCtrlA(.ALUop('b 10), .Funct(funct), .ALU_control(control))
					case (funct)
					// ADD
					6'b 100000: ALU_control <= 4'b 0010;
					// SUB
					6'b 100010: ALU_control <= 4'b 0110;
					// AND
					6'b 100100: ALU_control <= 4'b 0000;
					// OR
					6'b 100101: ALU_control <= 4'b 0001;
					// SLT
					6'b 101010: ALU_control <= 4'b 0111;
					// NOR
					6'b 100111: ALU_control <= 4'b 1100;
					// MUL
					6'b 100001: ALU_control <= 4'b 0100;
					// DIV
					6'b 100011: ALU_control <= 4'b 0101;
					endcase
					end
				// LW
				6'b 100011: begin
					Jump			=	0; 
					Branch		= 0; 
					MemRead		<= 1; 
					MemWrite		<= 0;
					Mem2Reg		= 1;
					ALUop			=	0; 
					Exception	= 0; 
					ALUsrc		= 1;
					RegWrite		= 1;
					RegDst		= 0;
					ALU_control = 4'b 0010;
					end
				// SW
				6'b 101011: begin
					Jump			=	0; 
					Branch		= 0; 
					MemRead		<= 0; 
					MemWrite		<= 1;
					Mem2Reg		= 0;
					ALUop			=	0; 
					Exception	= 0; 
					ALUsrc		= 1;
					RegWrite		= 0;
					RegDst		= 0;
					ALU_control = 4'b 0010;
					end
				// BEQ
				6'b 000100: begin
					Jump			<=	0; 
					Branch		<= 1; 
					MemRead		<= 0; 
					MemWrite		<= 0;
					Mem2Reg		<= 1'bx;
					ALUop			<=	0; 
					Exception	<= 0; 
					ALUsrc		<= 0;
					RegWrite		<= 0;
					RegDst		<= 1'bx;
					ALU_control <= 4'b 0110;
					end
				//BNE
				6'b 000101: begin
					Jump			<=	0; 
					Branch		<= 1; 
					MemRead		<= 0; 
					MemWrite		<= 0;
					Mem2Reg		<= 0;
					ALUop			<=	0; 
					Exception	<= 0; 
					ALUsrc		<= 0;
					RegWrite		<= 0;
					RegDst		<= 0;
					ALU_control <= 4'b 0110;
					end
				//Jump
				6'b 000001: begin
					Jump			<=	1; 
					Branch		<= 0; 
					MemRead		<= 0; 
					MemWrite		<= 0;
					Mem2Reg		<= 0;
					ALUop			<=	0; 
					Exception	<= 0; 
					ALUsrc		<= 0;
					RegWrite		<= 0;
					RegDst		<= 0;
					ALU_control <= 4'b 0010;
					end
				//ADDI
				6'b 001000: begin
					Jump			<=	0; 
					Branch		<= 0; 
					MemRead		<= 0; 
					MemWrite		<= 0;
					Mem2Reg		<= 0;
					ALUop			<=	0; 
					Exception	<= 0; 
					ALUsrc		<= 1;
					RegWrite		<= 1;
					RegDst		<= 0;
					ALU_control <= 4'b 0010;
					end
				//SLTI
				6'b 001010: begin
					Jump			<=	0; 
					Branch		<= 0; 
					MemRead		<= 0; 
					MemWrite		<= 0;
					Mem2Reg		<= 0;
					ALUop			<=	0; 
					Exception	<= 0; 
					ALUsrc		<= 1;
					RegWrite		<= 1;
					RegDst		<= 0;
					ALU_control <= 4'b 1000;
					end				
		endcase
	end

endmodule
