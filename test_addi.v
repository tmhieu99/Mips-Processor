`timescale 1ns/1ns
module test_addi();
wire [31:0] result;
wire [7:0] status; 
reg [31:0] machinecode;
initial begin
machinecode = 32'b00100000000010000000000000000101;
#10
machinecode = 32'b00100001000010000000000000000011;
end
ADDI addi1(result, status, machinecode);
endmodule