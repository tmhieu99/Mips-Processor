module Adder(output [31:0] out, input [31:0] inadd1, input [31:0] inadd2);
reg [31:0] outtemp;
always@(*)
begin
case(inadd2)
32'd4:	outtemp = inadd1 + inadd2;
default: 
begin
outtemp = inadd1 + inadd2<<2;
end
endcase
end
assign out = outtemp;

endmodule
