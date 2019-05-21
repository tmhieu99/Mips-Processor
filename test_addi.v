`timescale 1ns/1ns
module test_addi();
wire [31:0] result;
wire [7:0] status; 
reg [31:0] machinecode;
initial begin

machinecode = 32'b00100000000010010000000000000100; //addi $t1, $zero, 0x4
#10
machinecode = 32'b00100000000010100000000000000100; //addi $t2, $zero, 0x9
#10
/*machinecode = 32'b00000001001010100101100000100000; //add $t3 $t1 $t2
#10
machinecode = 32'b00100001001010010000000000000111; // addi $t1, $t1 , 0x6
#10
machinecode = 32'b00000001001010110110000000100000; //add $t4, $t1, $t3
#10
machinecode = 32'b00000001010010010110000000100010; // sub $t4, $t2, $t1 
#10
machinecode = 32'b00000001010010010110000000100100; // and t4 t2 t1
#10
machinecode = 32'b00000001010010010110000000100101; // or t4 t2 t1
#10
machinecode = 32'b00000001010010010110000000101010; // slt t4 t2 t1
#10
machinecode = 32'b00000001001010100110000000101010;// slt t4 t1 t2
#10
machinecode = 32'b10101101010010010000000000000000; // sw t1, 0(t2);
#10
machinecode = 32'b10001101010010110000000000000000; // lw t3, 0(t2);
#10
machinecode = 32'b10001101011011000000000000000100; //lw t4, 4(t3);
#10
machinecode = 32'b10001101011011010000000000000100; //lw t5 , 0x4(t3)
#10*/
machinecode = 32'b00010001001010101111111111111111; // beq t1, t2, 0xFFFF
end
ADDI addi1(result, status, machinecode);
endmodule