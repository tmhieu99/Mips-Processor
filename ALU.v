module ALU(
input [3:0] ALU_control,
input [31:0] ALU_op_1,
input [31:0] ALU_op_2,
output wire [31:0] ALU_result,
output reg [7:0] ALU_status = 8'b00000000);
reg [63:0] result;
wire [63:0] op1;
wire [63:0] op2;
reg [5:0] test_op1 = 63;
reg [5:0] test_op2 = 63;
reg [5:0] test_result = 63;
assign ALU_result = result[31:0];
assign op1= {{32{ALU_op_1[31]}},ALU_op_1};
assign op2 = {{32{ALU_op_2[31]}},ALU_op_2};
always@(*)
	begin
		
		
		case(ALU_control)
		4'b0010:	
		begin
		result = op1 + op2;
		if((result/4)*4!=result || (result/2)*2!=result)
		begin
		ALU_status = ALU_status+8'b00001000;
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
		ALU_status = ALU_status+8'b00000100;
		end
		end
		default:	result = op1 + op2;
		endcase
	if(result == 0)
	begin
	ALU_status = ALU_status+8'b10000000; 
	end
	if(result[63:31]>0 && result[63:31]<33'h1FFFFFFFF)
	begin
	ALU_status = ALU_status+8'b01000000; 
	end
	if(result[63]==1)
	begin
	ALU_status = ALU_status+8'b00010000; 
	end
	if (ALU_control != 4'b0101)
		begin
		while(result[test_result] == result[63] && test_result != 0) 
			begin
			test_result = test_result - 1;
			end
		while(op1[test_op1] == op1[63] && test_op1 != 0) 
			begin
			test_op1 = test_op1 - 1;
			end
		while(op2[test_op2] == op2[63] && test_op2 != 0)
			begin
			test_op2 = test_op2 - 1;
			end
		if ( test_result > test_op1 && test_result > test_op2 )
			begin
			ALU_status = ALU_status + 8'b00100000;
			end
		end
	end

endmodule
