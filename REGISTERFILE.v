module REGISTERFILE(
input [5:0] REG_address1,
input [5:0] REG_address2,
input [5:0] REG_address_wr,
input REG_write_1,
input [31:0] REG_data_wb_in1,
output reg [31:0] REG_data_out1,
output reg [31:0] REG_data_out2
);
reg [31:0] register [0:31];
always@(REG_address2,REG_address_wr,REG_data_wb_in1,REG_address1,register[REG_address1], register[REG_address2])
begin
if(REG_write_1 == 1'b1)
begin
register[REG_address_wr] = REG_data_wb_in1;
end
if (REG_address2 == 0) REG_data_out2 = 0;
else REG_data_out2 = register[REG_address2];
if (REG_address1 == 0) REG_data_out1 = 0;
else REG_data_out1 = register[REG_address1];
end
endmodule