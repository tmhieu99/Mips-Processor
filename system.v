module system (
input SYS_clk,
input SYS_reset,
input SYS_load,
input [31:0] SYS_pc_val,
input [31:0] SYS_output_sel,
output [26:0] SYS_leds);
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
wire[31:0] ins_add;
wire[31:0] machinecode;
wire  Jump,			//10 
					Branch,		//9 
					MemRead,		//8 
					MemWrite,	//7 
					Mem2Reg,				//54 
					Exception,	//3 
					ALUsrc, 		//2
					RegWrite,	//1 
					RegDst;	
wire [3:0] ALU_ctrl;
wire [31:0] ALU_res;
wire[1:0] ALU_op;
wire [4:0] outmux1;
wire [31:0] outmux2;
wire [31:0] outmux3;
wire [31:0] outmux4;
wire [31:0] outmux5;
wire [31:0] outext;
wire [31:0] outram;
wire outand;
wire [31:0] out1;
wire [31:0] out2;
wire [31:0] outadd1;
wire [31:0] outadd2;
wire [31:0] outadd3;
wire clk_temp_initial;
wire [7:0] status;
reg [31:26] opcodetemp;
reg [5:0] functemp;

assign opcode = opcodetemp;
assign func = functemp;

always @(clk_temp_initial)
begin
	opcodetemp =  machinecode [31:26];
	functemp = machinecode[5:0];
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


PC_counter pc(ins_add, SYS_clk, outmux5);

Adder add1(outadd1, ins_add, 32'd4);

Adder add2(outadd2, outadd1, {{6{1'b0}},machinecode[25:0]});

Adder add3(outadd3, outadd1, outext);

mux32 mux4(outadd1, outadd3, outand, outmux4);

mux32 mux5(outmux4, outadd2, Jump, outmux5);

IMEM ins(ins_add, clk_temp_initial, machinecode);

control ctrl(opcode,func,Jump, Branch, MemRead, MemWrite, 
Mem2Reg, ALU_op, Exception, ALUsrc, RegWrite, RegDst, ALU_ctrl);

Mux2to1 mux1(rt, rd, RegDst, outmux1);

SignExtend ext(imme, outext);

REGISTERFILE reg1(rs, rt, outmux1, RegWrite, outmux3, out1, out2);

mux32 mux2(out2, outext, ALUsrc, outmux2);

ALU alu1(ALU_ctrl, out1, outmux2, ALU_res, status);

and(outand,Branch,status[7]);

RAM ram(ALU_res, out2, memwritetemp, memreadtemp,clktemp, outram);

mux32 mux3(ALU_res, outram, Mem2Reg, outmux3);
endmodule
