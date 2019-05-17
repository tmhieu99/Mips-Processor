module Mux2to1 (a, b, ctrl, out);

	parameter n=32;

	input  [4:0] a;
	input  [4:0] b;
	input  ctrl;
	output reg [4:0] out;

	always@(a,b,ctrl)
begin
	out = ctrl?b:a;
end

endmodule
