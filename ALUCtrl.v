module ALUCtrl(ALUop, Funct, ALU_control);
  input [1:0] ALUop;
  input [5:0] Funct;
  output reg [3:0] ALU_control;

  always @(*) begin
    case (ALUop)
    // Load and Store: ADD
    2'b 00: ALU_control = 'b 0010;
    // Branch equal/not equal: SUB
    2'b 01: ALU_control = 'b 0110;
    // R-type
    2'b 10:
      case (Funct)
      // ADD
      6'b 100000: ALU_control = 'b 0010;
      // SUB
      6'b 100010: ALU_control = 'b 0110;
      // AND
      6'b 100100: ALU_control = 'b 0000;
      // OR
      6'b 100101: ALU_control = 'b 0001;
      // SLT
      6'b 101010: ALU_control = 'b 0111;
		// NOR
		6'b 100111: ALU_control = 'b 1100;
		// MUL
		6'b 100001: ALU_control = 'b 0100;
		// DIV
		6'b 100011: ALU_control = 'b 0101;
      endcase
    endcase
  end
endmodule
