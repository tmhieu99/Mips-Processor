module system (
input SYS_clk,
input SYS_reset,
input SYS_load,
input [31:0] SYS_pc_val,
input [31:0] SYS_output_sel,
input [3:0] out_sel,
output reg [31:0] SYS_leds,
output reg [31:0] out_PC);
wire [31:26] opcode;
wire [5:0] func;
wire[31:0] ins_add;
wire [31:0] machinecode;
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
wire [7:0] status;
wire outread;
wire outwrite;
	always@(negedge SYS_clk or negedge SYS_load or negedge SYS_reset)
	begin
		out_PC = ins_add[31:0];
		case(out_sel)
		4'b0001: SYS_leds[31:0] = machinecode[31:0];
		4'b0010: SYS_leds[31:0] = out1[31:0];
		4'b0011: SYS_leds[31:0] = out2[31:0];
		4'b0100: SYS_leds[31:0] = ALU_res[31:0];
		4'b0101: SYS_leds[31:0] = { {24{1'b0}} , status[7:0] };
		4'b0110: SYS_leds[31:0] = outram [31:0];
		endcase
	end


PC_counter pc(ins_add, SYS_clk ,SYS_reset, outmux5);

Adder add1(outadd1, ins_add, 32'd4);

Adder add2(outadd2, outadd1, {{6{1'b0}},machinecode[25:0]});

Adder add3(outadd3, outadd1, outext);

mux32 mux4(outadd1, outadd3, outand, outmux4);

mux32 mux5(outmux4, {{6{outadd2[25]}},outadd2[25:0]}, Jump, outmux5);

IMEM ins(ins_add, machinecode);

control ctrl(machinecode [31:26],machinecode[5:0],Jump, Branch, MemRead, MemWrite, 
Mem2Reg, ALU_op, Exception, ALUsrc, RegWrite, RegDst, ALU_ctrl);

Mux2to1 mux1(machinecode[20:16], machinecode[15:11], RegDst, outmux1);

SignExtend ext(machinecode[15:0], outext);

REGISTERFILE reg1(machinecode[25:21], machinecode[20:16], outmux1, RegWrite, outmux3, SYS_clk,SYS_reset, out1, out2);

mux32 mux2(out2, outext, ALUsrc, outmux2);

ALU alu1(ALU_ctrl, out1, outmux2, ALU_res, status);

and(outand,Branch,status[7]);

exception ex(outwrite, outread, status, MemRead, MemWrite);

RAM ram(ALU_res, out2, outwrite, outread, SYS_clk ,SYS_reset, outram);

mux32 mux3(ALU_res, outram, Mem2Reg, outmux3);
endmodule
