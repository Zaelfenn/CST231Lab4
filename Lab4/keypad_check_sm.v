module keypad_check_sm(
input clk,
input rst,
input [3:0] col_check,
output reg [3:0] row_check,
output reg [3:0] dout,
output reg ena
);

//4 states to check 4 rows
//4 states to check 4 collumns
//1 state to debounce press
//1 state to output press
//1 state for holding press
//4 + 4 + 1 + 1 + 1 = 2(4) + 3(1) = 8 + 3 = 11 states total

reg [10:0] state;
reg [2:0] counter;
always @(negedge clk)
begin
	if (rst)
		state <= 11'b00000000001;
	else
	case(state)
		11'b00000000001:	//scan row 1
			begin
				state <= 11'b00000010000; //collumns row 1
			end
			
		11'b00000000010:	//scan row 2
			begin
				state <= 11'b00000100000; //collumns row 2
			end
			
		11'b00000000100:	//scan row 3
			begin
				state <= 11'b00001000000; //collumns row 3
			end
			
		11'b00000001000: //scan row 4
			begin
				state <= 11'b00010000000; //collumns row 4
			end
			
		11'b00000010000: //scan collumns on row 1
			begin
				if (dout == 4'b0)
					state <= 11'bb00000000010;	//scan row 2
				else
					state <= 11'b00100000000; //debounce button
			end
			
		11'b00000100000: //scan collumns on row 2
			begin
				if (dout == 4'b0)
					state <= 11'bb00000000100;	//scan row 3
				else
					state <= 11'b00100000000; //debounce button
			end
			
		11'b00001000000: //scan collumns on row 3
			begin
				if (dout == 4'b0)
					state <= 11'bb00000001000;	//scan row 4
				else
					state <= 11'b00100000000; //debounce button
			end
			
		11'b00010000000: //scan collumns on row 4
			begin
				if (dout == 4'b0)
					state <= 11'bb00000000001;	//scan row 1
				else
					state <= 11'b00100000000; //debounce button
			end
			
		11'b00100000000:
			begin
				if (counter > 0)
					state <= state;
				else
					state <= 11'b0100000000; //output state
			end
			
		11'b01000000000:
			begin
				state <= 11'b1000000000; //hold state
			end
			
		11'b10000000000:
			begin
				if (col_check == 4'b1111)
					state <= 11'b0000000001; //check row 1
				else
					state <= state; //hold state
			end
			
		default:
			begin
				state <= 11'b0000000001; //check row 1
			end
		endcase
end


always @(state)
begin
	case(state)
		11'b00000000001:	//scan row 1
			begin
				row_check <= 4'b1110;
				ena <= 1'b0;
				dout <= 4'b0;
				counter <= 3'h5;
			end
			
		11'b00000000010:	//scan row 2
			begin
				row_check <= 4'b1101;
				ena <= 1'b0;
				dout <= 4'b0;
				counter <= 3'h5;
			end
			
		11'b00000000100:	//scan row 3
			begin
				row_check <= 4'b1011;
				ena <= 1'b0;
				dout <= 4'b0;
				counter <= 3'h5;
			end
			
		11'b00000001000:	//scan row 4
			begin
				row_check <= 4'b0111;
				ena <= 1'b0;
				dout <= 4'b0;
				counter <= 3'h5;
			end
			
		11'b00000010000:	//scan collumns based on row 1
			begin
				row_check <= row_check;
				ena <= 1'b0;
				counter <= 3'h5;
				casex(col_check)
					4'bxxx0:	dout <= 4'b0001;		//row 1, col 1 = 1
					4'bxx01: dout <= 4'b0010;		//row 1, col 2 = 2
					4'bx011: dout <= 4'b0011;		//row 1, col 3 = 3
					4'b0111:	dout <= 4'b1010;		//row 1, col 4 = a
					default: dout <= 4'b0;
				endcase
			end
			
		11'b00000100000:	//scan collumns based on row 2
			begin
				row_check <= row_check;
				ena <= 1'b0;
				counter <= 3'h5;
				casex(col_check)
					4'bxxx0:	dout <= 4'b0100;	//row 2, col 1 = 4
					4'bxx01: dout <= 4'b0101;	//row 2, col 2 = 5
					4'bx011: dout <= 4'b0110;	//row 2, col 3 = 6
					4'b0111:	dout <= 4'b1011;	//row 2, col 4 = b
					default: dout <= 4'b0;
				endcase
			end
			
		11'b00001000000:	//scan colllumns based on row 3
			begin
				row_check <= row_check;
				ena <= 1'b0;
				counter <= 3'h5;
				casex(col_check)
					4'bxxx0:	dout <= 4'b0111;	//row 3, col 1 = 7
					4'bxx01: dout <= 4'b1000;	//row 3, col 2 = 8
					4'bx011: dout <= 4'b1001;	//row 3, col 3 = 9
					4'b0111:	dout <= 4'b1100;	//row 3, col 4 = c
					default: dout <= 4'b0;
				endcase
			end
			
		11'b00010000000:	//scan collumns based on row 4
			begin
				row_check <= row_check;
				ena <= 1'b0;
				counter <= 3'h5;
				casex(col_check)
					4'bxxx0:	dout <= 4'b1111;	//row 4, col 1 = * (15)
					4'bxx01: dout <= 4'b0;	//row 4, col 2 = 0
					4'bx011: dout <= 4'b1110;	//row 4, col 3 = # (14)
					4'b0111:	dout <= 4'b1101 ;	//row 4, col 4 = d
					default: dout <= 4'b0;
				endcase
			end
			
		11'b00100000000:	//debounce button (5ms)
			begin
				row_check <= row_check;
				ena <= 1'b0;
				dout <= dout;
				if (col_check < 4'b1111)
					counter <= 3'h5;
				else
					counter <= counter - 1;
			end
			
		11'b01000000000:	//send out signal
			begin
				counter <= 3'h5;
				row_check <= row_check;
				ena <= 1'b1;
				dout <= dout;
			end
			
		11'b10000000000:	//hold signal
			begin
				counter <= 3'h5;
				row_check <= row_check;
				ena <= 1'b0;
				dout <= 4'b0;
			end
			
		default:
			begin
				row_check <= 4'b1111;
				ena <= 1'b0;
				dout <= 4'b0;
				counter <= 3'h5;
			end
		
	endcase

end
endmodule


