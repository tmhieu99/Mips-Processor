module Adder(output [31:0] out, input [31:0] inadd1, input [31:0] inadd2);
reg [31:0] outtemp;
reg [31:0] inadd2_temp;
always@(*)
begin
case(inadd2)
32'd4:	outtemp = inadd1 + inadd2;
default: 
begin
inadd2_temp = inadd2<<2;
outtemp = inadd1 + inadd2_temp;	
end
endcase
end
assign out = outtemp;

endmodule
