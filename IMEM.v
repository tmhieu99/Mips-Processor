module IMEM(
input [31:0] IMEM_PC,
output reg[31:0] IMEM_instruction);

always@(IMEM_PC)
begin
	case(IMEM_PC)
		32'd0: IMEM_instruction <= 32'b00100010000100000000000000001111; //ADDI $s0 $s0 0x000F
		32'd4: IMEM_instruction <= 32'h20110014; //ADDI $s1 $zero 0x0014
		32'd8: IMEM_instruction <= 32'h20120024; //ADDI $s2 $zero 0x0024
		32'd12: IMEM_instruction <= 32'h02329820; //ADD $s3 $s1 $s2
		32'd16: IMEM_instruction <= 32'h0272402A; //SLT $t0 $s3 $s2*/
		32'd20: IMEM_instruction <= 32'b00100000000010010000000000000100; //addi $t1, $zero, 0x4
		32'd24: IMEM_instruction <= 32'b00100000000010100000000000000100; //addi $t2, $zero, 0x4
		32'd28: IMEM_instruction <= 32'b00000001011010100101100000100000; //add $t3 $t3 $t2
		32'd32: IMEM_instruction <= 32'b00100001001010010000000000000111; // addi $t1, $t1 , 0x7
		32'd36: IMEM_instruction <= 32'b00000001001010110110000000100000; //add $t4, $t1, $t3
		32'd40: IMEM_instruction <= 32'b00000001010010010110000000100010; // sub $t4, $t2, $t1 
		/*32'd24: IMEM_instruction <= 32'b00000001010010010110000000100100; // and t4 t2 t1
		32'd28: IMEM_instruction <= 32'b00000001010010010110000000100101; // or t4 t2 t1
		32'd32: IMEM_instruction <= 32'b00000001010010010110000000101010; // slt t4 t2 t1
		32'd36: IMEM_instruction <= 32'b00000001001010100110000000101010;// slt t4 t1 t2*/
		32'd44: IMEM_instruction <= 32'b10101101010010010000000000000000; // sw t1, 0(t2);
		32'd48: IMEM_instruction <= 32'b10001101010010110000000000000000; // lw t3, 0(t2);
		/*32'd32: IMEM_instruction <= 32'b10001101011011000000000000000100; //lw t4, 4(t3);
		32'd36: IMEM_instruction <= 32'b10001101011011010000000000000100; //lw t5 , 0x4(t3)
		32'd40: IMEM_instruction <= 32'b00100001010010100000000000000111; // addi t2 t2 0x7     ( t2 = t1)
		32'd44: IMEM_instruction <= 32'b00100000000010011111111111111111; // addi t1 zero 0xFFFF
		32'd84: IMEM_instruction <= 32'b00100001001010010001111111111111; //addi t1 t1 0x8FFF
		32'd88: IMEM_instruction <= 32'b00100001001010010001111111111111;*/ // addi t1 t1 0x8FFF
		32'd52: IMEM_instruction <= 32'b00001011111111111111111111101000; // j ve 0
		default: IMEM_instruction <= 32'h0;
	endcase
end
endmodule
