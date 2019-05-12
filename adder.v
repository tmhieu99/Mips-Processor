module adder (a, b, c);

	parameter n = 32;

	input [n-1:0] a,b;
	wire [32:0] w0;
	output [n-1:0] c;

	assign w0[0] = 0;

	genvar i;

	generate
		for (i = 0; i <= n-1; i = i + 1) 
			begin: add
				FullAdder FullAdder_inst(.a(a[i]),.b(b[i]), .cin(w0[i]), .cout(w0[i+1]), .s(c[i]));
			end
	endgenerate

endmodule

module FullAdder(a, b, cin, cout, s);

	input a, b, cin;
	output cout, s;

	assign {cout,s} = a + b + cin;

endmodule
