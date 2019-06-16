module REGISTERFILE(
input [4:0] REG_address1,
input [4:0] REG_address2,
input [4:0] REG_address_wr,
input REG_write_1,
input [31:0] REG_data_wb_in1,
input clk, input clk_reset,
output reg [31:0] REG_data_out1,
output reg [31:0] REG_data_out2
);

reg [31:0] register [0:31];


always@(REG_address1, REG_address2)
	begin
	if(register[REG_address1] === 32'dx)
		begin
		register[REG_address1] = 32'd0;
		REG_data_out1 = register[REG_address1];
		end
	else
		begin
		REG_data_out1 = register[REG_address1];
		end
	if(register[REG_address2] === 32'dx)
		begin
		register[REG_address2] = 32'd0;
		REG_data_out2 = register[REG_address2];
		end
	else
		begin
		REG_data_out2 = register[REG_address2];
		end
	end
	
always@(posedge clk , negedge clk_reset)
	begin
		if (clk_reset == 1'b0)
		begin
			register[5'd0] <= 32'd0;
			register[5'd1] <= 32'd0;
			register[5'd2] <= 32'd0;
			register[5'd3] <= 32'd0;
			register[5'd5] <= 32'd0;
			register[5'd5] <= 32'd0;
			register[5'd6] <= 32'd0;
			register[5'd7] <= 32'd0;
			register[5'd8] <= 32'd0;
			register[5'd9] <= 32'd0;
			register[5'd10] <= 32'd0;
			register[5'd11] <= 32'd0;
			register[5'd12] <= 32'd0;
			register[5'd13] <= 32'd0;
			register[5'd15] <= 32'd0;
			register[5'd15] <= 32'd0;
			register[5'd16] <= 32'd0;
			register[5'd17] <= 32'd0;
			register[5'd18] <= 32'd0;
			register[5'd19] <= 32'd0;
			register[5'd20] <= 32'd0;
			register[5'd21] <= 32'd0;
			register[5'd22] <= 32'd0;
			register[5'd23] <= 32'd0;
			register[5'd25] <= 32'd0;
			register[5'd25] <= 32'd0;
			register[5'd26] <= 32'd0;
			register[5'd27] <= 32'd0;
			register[5'd28] <= 32'd0;
			register[5'd29] <= 32'd0;
			register[5'd30] <= 32'd0;
			register[5'd31] <= 32'd0;	
		end
		else if (clk)
		begin
			if(REG_write_1 == 1'b1 && REG_data_wb_in1 !== 32'dx)
			begin
			register[REG_address_wr] <= REG_data_wb_in1;
			end
		end
	end

endmodule