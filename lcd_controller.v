module lcd_controller(
	load,SYS_reset,clk,rst,output_display,PC,LCD_DATA,LCD_RW,LCD_EN,LCD_RS
);
//Input
input load;
input SYS_reset;
input	clk; 					// 50MHz
input rst;					// LCD reset
input [31:0]	output_display;
input [31:0]	PC;

//	LCD Side
output reg [7:0] 	LCD_DATA;
output reg 			LCD_EN,LCD_RS;
output 				LCD_RW;

// LCD control
reg	[5:0]		lcursor;
reg	[3:0]		lstate;

reg	[5:0]		count_1;
reg	[11:0]	count_2;
reg	[14:0]	count_3;

reg 	[8:0]		en_DATA;

wire 	[8:0]		d0,d1,d2,d3,d4,d5,d6,d7;
wire 	[8:0]		b0,b1,b2,b3,b4,b5,b6,b7;

parameter 	t_1 			= 	16;
parameter 	t_2 			= 	2500;
parameter 	t_3 			= 	30000;

parameter	init_ins		=	0;
parameter	L0_ins		=	5;
parameter	changeline_ins	=	21;
parameter	L4_ins		=	22;
parameter	MAXNUM			=	38;

assign 		LCD_RW	= 	1'b0;

lcd_encoder en0   (output_display[3:0]  ,d0);
lcd_encoder en1   (output_display[7:4]  ,d1);
lcd_encoder en2   (output_display[11:8] ,d2);
lcd_encoder en3   (output_display[15:12],d3);
lcd_encoder en4   (output_display[19:16],d4);
lcd_encoder en5   (output_display[23:20],d5);
lcd_encoder en6   (output_display[27:24],d6);
lcd_encoder en7   (output_display[31:28],d7);

lcd_encoder en8	(PC[3:0]  ,b0);
lcd_encoder en9	(PC[7:4]  ,b1);
lcd_encoder en10  (PC[11:8] ,b2);
lcd_encoder en11  (PC[15:12],b3);
lcd_encoder en12  (PC[19:16],b4);
lcd_encoder en13  (PC[23:20],b5);
lcd_encoder en14  (PC[27:24],b6);
lcd_encoder en15  (PC[31:28],b7);


always@(posedge clk or negedge rst or negedge load or negedge SYS_reset)
	begin
		if(~rst || ~load ||~SYS_reset)
			begin
				lcursor		<=	0;
				lstate		<=	0;
				count_3	<=	0;
				count_2	<=	0;
				count_1	<= 0;
			end
		else begin
			if(lcursor<MAXNUM)
			begin
				case(lstate)
				
				0:	begin
						LCD_DATA			<=	en_DATA[7:0];
						LCD_RS			<=	en_DATA[8];
						lstate			<=	4'd1;
					end
					
				1: begin
						lstate			<=	4'd2;
					end
					
				2: begin
						LCD_EN			<=	1'b1;
						lstate			<=	4'd3;
					end
					
				3:	begin
						if(count_1 < t_1)
							count_1	<=	count_1+1'b1;
						else begin
							count_1	<= 6'd0;
							LCD_EN		<=	1'b0;
							lstate		<=	4'd4;					
						end
					end
					
				4:	begin
						if(lcursor<5) begin
							if(count_3 < t_3)
								count_3	<=	count_3+1'b1;
							else begin
								count_3	<=	0;
								lstate		<=	4'd5;
							end
						end
						else begin
							if(count_2 < t_2)
								count_2	<=	count_2+1'b1;
							else begin
								count_2	<=	0;
								lstate		<=	4'd5;							
							end
						end
					end
					
				5:	begin
						lcursor			<= lcursor+1'b1;
						lstate			<=	4'd0;
					end
				endcase
			end
		end
	end
always@(*)
begin
	case(lcursor)
	//	init
	init_ins+0:	en_DATA	<=	9'h038; 	
	init_ins+1:	en_DATA	<=	9'h00C; 	
	init_ins+2:	en_DATA	<=	9'h001;	
	init_ins+3:	en_DATA	<=	9'h006; 	
	init_ins+4:	en_DATA	<=	9'h080;
	
	//	Line 1		
	L0_ins+0:	en_DATA	<=	9'h16F;	// o
	L0_ins+1:	en_DATA	<=	9'h175;  // u
	L0_ins+2:	en_DATA	<=	9'h174;  // t
	L0_ins+3:	en_DATA	<=	9'h15F;	// _
	L0_ins+4:	en_DATA	<=	9'h176;	// v
	L0_ins+5:	en_DATA	<=	9'h161;	//	a
	L0_ins+6:	en_DATA	<=	9'h16C;	//	l
	L0_ins+7:	en_DATA	<=	9'h13A;	// :
	L0_ins+8:	en_DATA	<=	d7;
	L0_ins+9:	en_DATA	<=	d6;
	L0_ins+10:	en_DATA	<=	d5;
	L0_ins+11:	en_DATA	<=	d4;
	L0_ins+12:	en_DATA	<=	d3;
	L0_ins+13:	en_DATA	<=	d2;
	L0_ins+14:	en_DATA	<=	d1;
	L0_ins+15:	en_DATA	<=	d0;
	
	//	Change Line
	changeline_ins:en_DATA	<=	9'h0C0;
	
	//	Line 2		
	L4_ins+0:	en_DATA	<=	9'h150; //P
	L4_ins+1:	en_DATA	<=	9'h143; //C
	L4_ins+2:	en_DATA	<=	9'h13A; //:
	L4_ins+3:	en_DATA	<=	9'h120; //0
	L4_ins+4:	en_DATA	<=	9'h120; //0
	L4_ins+5:	en_DATA	<=	9'h120; //0
	L4_ins+6:	en_DATA	<=	9'h120; //0
	L4_ins+7:	en_DATA	<=	9'h120;  //0
	L4_ins+8:	en_DATA	<=	b7;
	L4_ins+9:	en_DATA	<=	b6;
	L4_ins+10:	en_DATA	<=	b5;
	L4_ins+11:	en_DATA	<=	b4;
	L4_ins+12:	en_DATA	<=	b3;
	L4_ins+13:	en_DATA	<=	b2;
	L4_ins+14:	en_DATA	<=	b1;
	L4_ins+15:	en_DATA	<=	b0;
	default:	en_DATA	<=	9'h120;
	endcase
end

endmodule