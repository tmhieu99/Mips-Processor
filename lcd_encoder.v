module lcd_encoder(d_in,d_o);
	
	input  [3:0]d_in;
	output [8:0]d_o;
	
	assign d_o=(d_in<4'b1010) ? {5'b10011,d_in}:{6'b101000,d_in[2:0]-1'b1};
	
endmodule
