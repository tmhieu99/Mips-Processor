module Mux2to1 (a, b, ctrl, out);

	parameter n=32;
	input  [4:0] a;
	input  [4:0] b;
	input  ctrl;
	output [4:0] out;
	reg[4:0] out1;
	always@(*)
begin
	out1 = ctrl?b:a;
end
assign out = out1;
endmodule
