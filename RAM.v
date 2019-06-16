module RAM(
input [31:0] DMEM_address,
input [31:0] DMEM_data_in,
input DMEM_mem_write,
input DMEM_mem_read,
input clk,
input reset,
output [31:0] DMEM_data_out
);
reg [31:0] mem [0:20];
/*always@(DMEM_address)
	begin
		if(DMEM_mem_read == 1 && DMEM_mem_write == 0)
			begin
			DMEM_data_out = mem[DMEM_address];
		end
	end*/
assign DMEM_data_out =(DMEM_mem_read == 1)?mem[DMEM_address]:32'h00000000;
always@(posedge clk , negedge reset)
	begin
	if (reset == 1'b0)
		begin
			mem[5'd0] <= 32'd0;
			mem[5'd1] <= 32'd0;
			mem[5'd2] <= 32'd0;
			mem[5'd3] <= 32'd0;
			mem[5'd5] <= 32'd0;
			mem[5'd5] <= 32'd0;
			mem[5'd6] <= 32'd0;
			mem[5'd7] <= 32'd0;
			mem[5'd8] <= 32'd0;
			mem[5'd9] <= 32'd0;
			mem[5'd10] <= 32'd0;
			mem[5'd11] <= 32'd0;
			mem[5'd12] <= 32'd0;
			mem[5'd13] <= 32'd0;
			mem[5'd15] <= 32'd0;
			mem[5'd15] <= 32'd0;
			mem[5'd16] <= 32'd0;
			mem[5'd17] <= 32'd0;
			mem[5'd18] <= 32'd0;
			mem[5'd19] <= 32'd0;
			mem[5'd20] <= 32'd0;
		end
	else if (clk)
		begin
		if (DMEM_mem_write) 
			begin
				mem[DMEM_address] <= DMEM_data_in;
			end
		end
	end
endmodule