module ShiftLeft2(a, out);

parameter n = 32;

input  [n-1:0] a;
output [n-1:0] out;

assign out = a << 2;

endmodule 