module PC_counter(output [31:0] ins_add, input clk, input[31:0] add_in);
reg [31:0] PC;
initial begin
PC = 32'h00000000;
end
always@(negedge clk)
begin
	if (add_in === 32'dx)
	begin
		PC <= 32'd0; 
	end
	else
	begin
		PC <= add_in;
	end
end
assign ins_add = PC;
endmodule
