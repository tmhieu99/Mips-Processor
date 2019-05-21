module PC_counter(output [31:0] ins_add, output clk_PC, input clk, input[31:0] add_in);
reg [31:0] PC;
reg clk_PC_temp = 0;
initial begin
PC = 32'hfffffffc;
end
always@(posedge clk)
begin
	PC = add_in;
	clk_PC_temp <= ~clk_PC_temp;	
end
assign ins_add = PC;
assign clk_PC = clk_PC_temp;
endmodule
