module ADDI(output [31:0] result,output [7:0] status, input [31:0] machinecode);
wire [31:26] opcode;
wire [5:0] func;
reg [25:21] rs ;
reg [20:16] rt ;
reg [15:11] rd ;
reg [15:0] imme;
reg memwritetemp;
reg memreadtemp;
reg clktemp = 0;
reg [31:0]ALU_restemp;
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
wire outor;	
wire[1:0] ALU_op;
wire [31:0] ALU_res;
wire [4:0] outmux1;
wire [31:0] outmux2;
wire [31:0] outmux3;
wire [31:0] outmux4;
wire [31:0] outext;
wire [31:0] outram;

assign result = ALU_res;


assign opcode =  machinecode [31:26];
assign func = machinecode[5:0];

always @(*)
begin
	rs <= machinecode[25:21];
	rt <= machinecode[20:16];
	rd <= machinecode[15:11];
	imme <= machinecode[15:0];
	clktemp <= 1;
end	

always@(posedge clktemp)
	begin
	ALU_restemp <= ALU_res;
	memwritetemp <= MemWrite;
	memreadtemp <= MemRead;
	clktemp <= 0;
	end


control ctrl(opcode, func,Jump, Branch, MemRead, MemWrite, 
Mem2Reg, ALU_op, Exception, ALUsrc, RegWrite, RegDst, ALU_ctrl);
Mux2to1 mux1(rt, rd, RegDst, outmux1);
SignExtend ext(imme, outext);
REGISTERFILE reg1(rs, rt, outmux1, RegWrite, outmux3, out1, out2);
mux32 mux2(out2, outext, ALUsrc, outmux2);
ALU alu1(ALU_ctrl, out1, outmux2, ALU_res, status);
and(outor,Branch,status[7]);
mux32 mux4(32'hAAAA, outext, Branch, outmux4);
RAM ram(ALU_res, out2, memwritetemp, memreadtemp,clktemp, outram);
mux32 mux3(ALU_res, outram, Mem2Reg, outmux3);
endmodule

