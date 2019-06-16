module display(hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7,data_in,load,clk,reset);
input [31:0] data_in;
input load;
input clk;
input reset;
output [6:0] hex0;
output [6:0] hex1;
output [6:0] hex2;
output [6:0] hex3;
output [6:0] hex4;
output [6:0] hex5;
output [6:0] hex6;
output [6:0] hex7;

hexto7segment hex_0(data_in[3:0],hex0);
hexto7segment hex_1(data_in[7:4],hex1);
hexto7segment hex_2(data_in[11:8],hex2);
hexto7segment hex_3(data_in[15:12],hex3);
hexto7segment hex_4(data_in[19:16],hex4);
hexto7segment hex_5(data_in[23:20],hex5);
hexto7segment hex_6(data_in[27:24],hex6);
hexto7segment hex_7(data_in[31:28],hex7);
endmodule