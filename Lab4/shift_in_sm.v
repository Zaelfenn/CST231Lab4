module shift_in_sm(
input clk,
input enable, 
input [3:0] din,					//0xE = done, 0xF = reset
input [4:0] counter,
output reg rst,
output reg [15:0] dout,
output reg ena
);

reg [6:0] state;

initial
begin

	dout <= 16'h0000;
	rst <= 1'b1;
	ena <= 1'b0;

end

always @ (negedge clk)
begin
if (counter > 14)				//counter overflow should be considered first
	begin
	state <= 7'b1000000;
	end
else if (enable)	//enable high = change state
	begin
		case (state)
			7'b0000001:				//reset state
				begin
					if (din == 14)	//done
						state <= 7'b0100000;
					else if (din == 15) //reset
						state <= state;
					else	//go to lowest bits changing
						state <= 7'b0000010;
				end
			7'b0000010:				//four lowest bits change
				begin
					if (din == 14)	//done
						state <= 7'b0100000;
					else if (din == 15) //reset
						state <= 7'b0000001;
					else
						state <= 7'b0000100;
				end
			7'b0000100:				//next four lowest bits change
				begin
					if (din == 14)	//done
						state <= 7'b0100000;
					else if (din == 15) //reset
						state <= 7'b0000001;
					else
						state <= 7'b0001000;
				end
			7'b0001000:				//next four lowest bits change
				begin
					if (din == 14)	//done
						state <= 7'b0100000;
					else if (din == 15) //reset
						state <= 7'b0000001;
					else
						state <= 7'b0010000;	//go to next state
				end
			7'b0010000:				//four highest bits change
				begin
					if (din == 14)	//done
						state <= 7'b0100000;
					else if (din == 15) //reset
						state <= 7'b0000001;
					else
						state <= 7'b0000010; //go back to lowest bits changing
				end
			7'b0100000:				//done state
				begin
					state <= 7'b0000001; //go to reset state
				end
			7'b1000000:				//timer done state
				begin
					state <= 7'b0100000; //go to done state
				end
				
			default:
				begin
					state <= 7'b0000001; //default to reset state
				end
			
		endcase
	end

	
else
	begin
		state <= state;		//otherwise, hold state
	end

end


always @(state)
begin
	case (state)
		7'b0000001:			//reset state- no output
			begin
				dout <= 16'h0000;		//oops, all zeroes!
				rst <= 1'b1;		//reset state resets
				ena <= 1'b0;		//dont check for valid code
			end
		7'b0000010:			//state 1- change bits 3:0
			begin
				dout <= {dout[15:4], din};		//change lowest bits
				rst <= 1'b0;						//don't reset
				ena <= 1'b0;						//dont check for valid code
			end
		7'b0000100:			//state 2- change bits 7:4
			begin
				dout <= {dout[15:8], din, dout[3:0]};	//change middle bits
				rst <= 1'b0;									//dont reset
				ena <= 1'b0;									//dont check for valid code
			end
		7'b0001000:			//state 3- change bits 11:8
			begin
				dout <= {dout[15:12], din, dout[7:0]};	//change middle bits
				rst <= 1'b0;									//dont reset
				ena <= 1'b0;									//dont check for valid code
			end
		7'b0010000:			//state 4- change bits 15:12
			begin
				dout <= {din, dout[11:0]};					//change highest bits
				rst <= 1'b0;									//dont reset
				ena <= 1'b0;									//dont check for valid code
			end
		7'b0100000:			//state 5- done state
			begin
				dout <= dout;									//dont change code
				rst <= 1'b0;									//dont reset
				ena <= 1'b1;									//do check for valid code
			end
		7'b1000000:			//state 6- counter overflow state
			begin
				dout <= dout;									//dont change code
				rst <= 1'b1;									//reset
				ena <= 1'b1;									//check for valid code
			end
		default:
			begin
				dout <= 16'h0000;				//change code to zeroes
				rst <= 1'b1;				//reset
				ena <= 1'b0;				//dont enable
			end
	
	endcase

end


endmodule