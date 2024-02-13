module SevenSegDecoder(
input [3:0] q,								 //input to display
output reg [0:6] light 					 //lights are active low, bits are in position (ex. hex0[6] = light[6])
);
always @ (q)
begin
	case (q)
		4'd0 : light = 7'b1000000;					//output 0
		4'd1 : light = 7'b1111001;					//output 1
		4'd2 : light = 7'b0100100;					//output 2
		4'd3 : light = 7'b0110000;					//output 3
		4'd4 : light = 7'b0011001;					//output 4
		4'd5 : light = 7'b0010010;					//output 5
		4'd6 : light = 7'b0000010;					//output 6
		4'd7 : light = 7'b1111000;					//output 7
		4'd8 : light = 7'b0000000;					//output 8
		4'd9 : light = 7'b0011000;					//output 9
		default: light = 7'b1111111;				//output nothing
endcase
end	

endmodule