module mux32 (a, b, ctrl, out);

	parameter n=32;

	input  [31:0] a;
	input  [31:0] b;
	input  ctrl;
	output [31:0] out;
	wire [31:0] ctrlext;
	assign ctrlext = {{31{ctrl}},ctrl};
	reg [31:0]out1;
	always@(*)
begin
	out1 = ctrl?b:a;
end
	assign out = out1;
endmodule
