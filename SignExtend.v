module SignExtend(a, out);

	input  [15:0] a;
	output reg [31:0] out;
	always@(a)
	begin
 	out = { {16{a[15]}} , a };
	end
endmodule
