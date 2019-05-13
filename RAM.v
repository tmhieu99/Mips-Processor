module RAM(
input [31:0] DMEM_address,
input [31:0] DMEM_data_in,
input DMEM_mem_write,
input DMEM_mem_read,
output reg[31:0] DMEM_data_out
);
reg [31:0] mem [0:1023];

always@(*)
begin
if(DMEM_mem_write == 1 && DMEM_mem_read==0)
begin
mem[DMEM_address] = DMEM_data_in;
end
else if(DMEM_mem_read == 1 &&DMEM_mem_write==0)
begin
DMEM_data_out = mem[DMEM_address];
end
end
endmodule