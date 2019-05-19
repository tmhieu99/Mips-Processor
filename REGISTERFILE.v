module REGISTERFILE(
input [4:0] REG_address1,
input [4:0] REG_address2,
input [4:0] REG_address_wr,
input REG_write_1,
input [31:0] REG_data_wb_in1,
output [31:0] REG_data_out1,
output [31:0] REG_data_out2
);
reg [31:0] out1;
reg [31:0] out2;
reg [31:0] register [0:31];
always@(REG_address1, REG_address2 , REG_address_wr)
	begin
	if(register[REG_address1] === 32'dx)
		begin
		register[REG_address1] = 32'd0;
		out1 = register[REG_address1];
		end
	else
		begin
		out1 = register[REG_address1];
		end
	if(register[REG_address2] === 32'dx)
		begin
		register[REG_address2] = 32'd0;
		out2 = register[REG_address2];
		end
	else
		begin
		out2 = register[REG_address2];
		end
	end
always@(REG_address_wr , REG_data_wb_in1 )
	begin
	if(REG_write_1 == 1'b1 && REG_data_wb_in1 !== 32'dx)
		begin
		register[REG_address_wr] = REG_data_wb_in1;
		end
	end
assign REG_data_out1 = out1;
assign REG_data_out2 = out2;
endmodule