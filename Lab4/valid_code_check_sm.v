module valid_code_check_sm(
input clk,
input enable,
input [2:0] counter,
input [15:0] din,
output reg err,		//error light
output reg nerr,		//success light
output reg ena,		//enable counter 
output reg rst			//reset counter
);

reg [3:0] state;

always @(negedge clk)
begin
if (counter > 4)
	begin
		state <= 4'b0001;		//reset state
	end
else if (enable)
	begin
		case (state)
			4'b0001:			//reset state
			begin
				state <= 4'b0010;
			end
			4'b0010:			//checking state
			begin
				case(din)
					16'h1234: state <= 4'b1000;
					16'habcd: state <= 4'b1000;
					16'h1122: state <= 4'b1000;
					16'h1010: state <= 4'b1000;
					16'h123a: state <= 4'b1000;
					16'h2580: state <= 4'b1000;		//non error state if correct code
					
					default: state <= 4'b0100;		//error state if not correct code
				endcase
			end
			4'b0100:			//error state
			begin
				state <= state;
			end
			4'b1000:			//no error state
			begin
				state <= state;
			end
			
			default:
			begin
				state <= 4'b0001;
			end
		endcase
	end

else
	begin
		state <= state;
	end
end


always @(state)
begin

	case(state)
		4'b0001:			//reset state
		begin
			err <= 1'b0;
			nerr <= 1'b0;
			ena <= 1'b0;
			rst <= 1'b1;
		end
		4'b0010:			//checking state
		begin
			err <= 1'b0;
			nerr <= 1'b0;
			ena <= 1'b1;
			rst <= 1'b0;
		end
		4'b0100:			//error state
		begin
			err <= 1'b1;
			nerr <= 1'b0;
			ena <= 1'b1;
			rst <= 1'b0;
		end
		4'b1000:			//no error state
		begin
			err <= 1'b0;
			nerr <= 1'b1;
			ena <= 1'b1;
			rst <= 1'b0;
		end

	endcase
end




endmodule