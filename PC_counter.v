module PC_counter(output [31:0] ins_add, input clk ,input clk_reset,input[31:0] add_in);
reg [31:0] PC;
initial begin
PC = 32'h00000000;
end

always@(posedge clk, negedge clk_reset)
begin
	if (clk_reset == 1'b0)
	begin
		PC <= 32'd0;
	end
	else 
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
end

assign ins_add = PC;
endmodule
