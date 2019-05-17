module REGISTERFILE(
input [4:0] REG_address1,
input [4:0] REG_address2,
input [4:0] REG_address_wr,
input REG_write_1,
input [31:0] REG_data_wb_in1,
output [31:0] REG_data_out1,
output [31:0] REG_data_out2
);
reg [31:0] register [0:31];
initial begin
register[0] = 0;
register[1] = 0;
register[2] = 0;
register[3] = 0;
register[4] = 0;
register[5] = 0;
register[6] = 0;
register[7] = 0;
register[8] = 0;
register[9] = 0;
register[10] = 0;
register[11] = 0;
register[12] = 0;
register[13] = 0;
register[14] = 0;
register[15] = 0;
register[16] = 0;
register[17] = 0;
register[18] = 0;
register[19] = 0;
register[20] = 0;
register[21] = 0;
register[22] = 0;
register[23] = 0;
register[24] = 0;
register[25] = 0;
register[26] = 0;
register[27] = 0;
register[28] = 0;
register[29] = 0;
register[30] = 0;
register[31] = 0;



end
always@(REG_address2,REG_address_wr,REG_data_wb_in1,REG_address1,register[REG_address1], register[REG_address2])
begin
if(REG_write_1 == 1'b1)
begin
register[REG_address_wr] = REG_data_wb_in1;
end
end
assign REG_data_out1 = register[REG_address1];
assign REG_data_out2 = register[REG_address2];
endmodule