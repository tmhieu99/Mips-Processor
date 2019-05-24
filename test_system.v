`timescale 1ns/1ns
module test_system();
reg SYS_clk;
reg SYS_reset;
reg SYS_load;
reg [31:0] SYS_pc_val;
reg [31:0] SYS_output_sel;
wire[26:0] SYS_leds;
initial
	begin
	SYS_clk = 1'b0;
	SYS_reset = 0;
	SYS_load = 0;
	SYS_pc_val = 32'b0;
	SYS_output_sel = 32'b0;
	forever #10 SYS_clk = ~SYS_clk;
end
system sys( SYS_clk,
SYS_reset,
 SYS_load,
 SYS_pc_val,
 SYS_output_sel,
 SYS_leds);
endmodule