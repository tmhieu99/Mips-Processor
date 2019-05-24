module ALU(
input [3:0] ALU_control,
input [31:0] ALU_op_1,
input [31:0] ALU_op_2,
output wire [31:0] ALU_result,
output wire [7:0] ALU_status );
reg [63:0] result;
reg [7:0] status = 8'b00000000;
wire [63:0] op1;
wire [63:0] op2;
assign ALU_result = result[31:0];
assign ALU_status = status[7:0];
assign op1 = {{32{ALU_op_1[31]}},ALU_op_1};
assign op2 = {{32{ALU_op_2[31]}},ALU_op_2};
always@(ALU_control, ALU_op_1, ALU_op_2)
	begin
		
		status = 8'b00000000;
		case(ALU_control)
		4'b0010:	
		begin
			result = op1 + op2;
			if(op1[1:0] != 2'b00 || op1[0] != 1'b0)
			begin
			status = status+8'b00001000;
			end
		end
		4'b0110:	result = op1 - op2;
		4'b0000:	result = op1 & op2;
		4'b0001:	result = op1 | op2;
		4'b0111:	result = (op1 < op2)?1:0;
		4'b1100:	result = ~(op1 | op2);
		4'b0100:	result = op1 * op2;
		4'b0101:	
		begin
		if(op2!=32'h0)
		begin
		result = op1 / op2;
		end
		else
		begin
		status = status+8'b00000100;
		end
		end
		default:	result = op1 + op2;
		endcase
	if(result == 0)
	begin
	status = status+8'b10000000; 
	end
	if(result[63:31]>0 && result[63:31]<33'h1FFFFFFFF)
	begin
	status = status+8'b01000000; 
	end
	if(result[63]==1)
	begin
	status = status+8'b00010000; 
	end
	if (result[32:31] == 2'b10 || result[32:31] == 2'b01)
		begin
			status = status + 8'b00100000;
		end
	end
endmodule
