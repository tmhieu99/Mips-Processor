module RAM(
input [31:0] DMEM_address,
input [31:0] DMEM_data_in,
input DMEM_mem_write,
input DMEM_mem_read,
input clk,
output [31:0] DMEM_data_out
);
reg [31:0] out;
reg [31:0] mem [0:255];
assign DMEM_data_out = out;
always@(negedge clk)
begin
	if(DMEM_mem_write == 1 && DMEM_mem_read==0)
		begin
		mem[DMEM_address] = DMEM_data_in;
		end
	else if(DMEM_mem_read == 1 && DMEM_mem_write == 0)
		begin
		if (mem[DMEM_address] === 32'dx)
		begin
		mem[DMEM_address] = 31'd0;
		end
		out = mem[DMEM_address];
		end
end
endmodule