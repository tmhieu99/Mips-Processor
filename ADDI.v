module ADDI(output [31:0] result,output [7:0] status, input [31:0] machinecode);
wire [31:26] opcode;
wire [5:0] func;
wire [25:21] rs ;
wire [20:16] rt ;
wire [15:11] rd ;
wire [15:0] imme;
wire [31:0] out1;
wire [31:0] out2;
wire [3:0] ALU_ctrl;
wire write;
wire  Jump,			//10 
					Branch,		//9 
					MemRead,		//8 
					MemWrite,	//7 
					Mem2Reg,				//54 
					Exception,	//3 
					ALUsrc, 		//2
					RegWrite,	//1 
					RegDst;		
wire[1:0] ALU_op;
wire [31:0] ALU_res;
wire [4:0] outmux1;
wire [31:0] outext;
assign opcode =  machinecode [31:26];
assign func = machinecode[5:0];
assign rs = machinecode[25:21];
assign rt = machinecode[20:16];
assign rd = machinecode[15:11];
assign imme = machinecode[15:0];
assign result = ALU_res;
control ctrl(opcode, func,Jump, Branch, MemRead, MemWrite, 
Mem2Reg, ALU_op, Exception, ALUsrc, RegWrite, RegDst, ALU_ctrl);
Mux2to1 mux1(rt, rd, RegDst, outmux1);
SignExtend ext(imme, outext);
REGISTERFILE reg1(rs, rt, outmux1, RegWrite, ALU_res, out1, out2);
ALU alu1(ALU_ctrl, out1, outext, ALU_res, status);
endmodule

