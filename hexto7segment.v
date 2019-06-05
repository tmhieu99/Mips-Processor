module hexto7segment(
    input  [3:0]x,
    output reg [6:0]z
    );
always @(*)
case (x)
4'b0000 :      	//Hexadecimal 0
z = 7'b1111110;
4'b0001 :    		//Hexadecimal 1
z = 7'b0110000  ;
4'b0010 :  		// Hexadecimal 2
z = 7'b1101101 ; 
4'b0011 : 		// Hexadecimal 3
z = 7'b1111001 ;
4'b0100 :		// Hexadecimal 4
z = 7'b0110011 ;
4'b0101 :		// Hexadecimal 5
z = 7'b1011011 ;  
4'b0110 :		// Hexadecimal 6
z = 7'b1011111 ;
4'b0111 :		// Hexadecimal 7
z = 7'b1110000;
4'b1000 :     		 //Hexadecimal 8
z = 7'b1111111;
4'b1001 :    		//Hexadecimal 9
z = 7'b1111011 ;
4'b1010 :  		// Hexadecimal A
z = 7'b1110111 ; 
4'b1011 : 		// Hexadecimal B
z = 7'b0011111;
4'b1100 :		// Hexadecimal C
z = 7'b1001110 ;
4'b1101 :		// Hexadecimal D
z = 7'b0111101 ;
4'b1110 :		// Hexadecimal E
z = 7'b1001111 ;
4'b1111 :		// Hexadecimal F
z = 7'b1000111 ;
endcase
 
endmodule