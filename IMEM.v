module IMEM(
input [7:0] IMEM_PC,
output reg[31:0] IMEM_instruction);
always@(IMEM_PC)
begin
	case(IMEM_PC)
8'h00: IMEM_instruction = 32'h2010000F;
8'h01: IMEM_instruction = 32'h20110014;
8'h02: IMEM_instruction = 32'h20120024;
8'h03: IMEM_instruction = 32'h02329820;
8'h04: IMEM_instruction = 32'h0253402A;
	endcase
end
endmodule
