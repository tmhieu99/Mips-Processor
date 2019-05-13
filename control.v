module control(Opcode, funct, Jump, Branch, MemRead, MemWrite, 
Mem2Reg, ALUop, Exception, ALUsrc, RegWrite, RegDst, ALU_control);
	input [5:0] Opcode, funct;
	output reg  Jump,			//10 
					Branch,		//9 
					MemRead,		//8 
					MemWrite,	//7 
					Mem2Reg,		//6 
					ALUop,		//54 
					Exception,	//3 
					ALUsrc, 		//2
					RegWrite,	//1 
					RegDst;		//0
	output reg [3:0] ALU_control;
always@(*) 
	begin
		case(Opcode)
				// R format
				'b 000000: begin 
					Jump			<=	0; 
					Branch		<= 0; 
					MemRead		<= 0; 
					MemWrite		<= 0;
					Mem2Reg		<= 0;
					ALUop			<=	'b10; 
					Exception	<= 0; 
					ALUsrc		<= 0;
					RegWrite		<= 1;
					RegDst		<= 1;
					//ALUCtrl ALUCtrlA(.ALUop('b 10), .Funct(funct), .ALU_control(control))
					case (funct)
					// ADD
					'b 100000: ALU_control <= 'b 0010;
					// SUB
					'b 100010: ALU_control <= 'b 0110;
					// AND
					'b 100100: ALU_control <= 'b 0000;
					// OR
					'b 100101: ALU_control <= 'b 0001;
					// SLT
					'b 101010: ALU_control <= 'b 0111;
					// NOR
					'b 100111: ALU_control <= 'b 1100;
					// MUL
					'b 100001: ALU_control <= 'b 0100;
					// DIV
					'b 100011: ALU_control <= 'b 0101;
					endcase
					end
				// LW
				'b 100011: begin
					Jump			<=	0; 
					Branch		<= 0; 
					MemRead		<= 1; 
					MemWrite		<= 0;
					Mem2Reg		<= 1;
					ALUop			<=	0; 
					Exception	<= 0; 
					ALUsrc		<= 1;
					RegWrite		<= 1;
					RegDst		<= 0;
					ALU_control <= 'b 0010;
					end
				// SW
				'b 101011: begin
					Jump			<=	0; 
					Branch		<= 0; 
					MemRead		<= 0; 
					MemWrite		<= 1;
					Mem2Reg		<= 0;
					ALUop			<=	0; 
					Exception	<= 0; 
					ALUsrc		<= 1;
					RegWrite		<= 0;
					RegDst		<= 0;
					ALU_control <= 'b 0010;
					end
				// BEQ
				'b 000100: begin
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
					ALU_control <= 'b 0110;
					end
				//BNE
				'b 000101: begin
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
					ALU_control <= 'b 0110;
					end
				//Jump
				'b 000001: begin
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
					ALU_control <= 'b 0010;
					end
				//ADDI
				'b 001000: begin
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
					ALU_control <= 'b 0010;
					end
				//SLTI
				'b 001010: begin
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
					ALU_control <= 'b 1000;
					end				
		endcase
	end

endmodule
