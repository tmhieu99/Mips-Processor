module Mux2to1 (a, b, ctrl, out);

parameter n=32;

input  [n-1:0] a;
input  [n-1:0] b;
input  ctrl;
output [n-1:0] out;

assign out = ctrl ? b : a;

endmodule

