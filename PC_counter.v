module PC_counter(output [31:0] ins_add, input clk, input[31:0] add_in);
reg [31:0] PC;
initial begin
PC = 32'h00000000;
end
always@(posedge clk)
begin
	PC = add_in;
end
assign ins_add = PC;
endmodule
