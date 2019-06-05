module RAM(
input [31:0] DMEM_address,
input [31:0] DMEM_data_in,
input DMEM_mem_write,
input DMEM_mem_read,
input clk,
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
always@(posedge clk)
	begin
	if(DMEM_mem_write) 
		begin
		mem[DMEM_address] <= DMEM_data_in;
		end
	end
endmodule