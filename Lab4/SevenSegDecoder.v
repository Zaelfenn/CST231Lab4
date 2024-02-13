module SevenSegDecoder(
input [3:0] q,								 //input to display
output reg [0:6] light 					 //lights are active low, bits are in position (ex. hex0[6] = light[6])
);
always @ (q)
begin
	case (q)
		4'h0 : light = 7'b1000000;					//output 0
		4'h1 : light = 7'b1111001;					//output 1
		4'h2 : light = 7'b0100100;					//output 2
		4'h3 : light = 7'b0110000;					//output 3
		4'h4 : light = 7'b0011001;					//output 4
		4'h5 : light = 7'b0010010;					//output 5
		4'h6 : light = 7'b0000010;					//output 6
		4'h7 : light = 7'b1111000;					//output 7
		4'h8 : light = 7'b0000000;					//output 8
		4'h9 : light = 7'b0011000;					//output 9
		4'ha : light = 7'b0001000;					//output A
		4'hb : light = 7'b0000011;					//output b
		4'hc : light = 7'b1000110;					//output C
		4'hd : light = 7'b0100001;					//output d
		default: light = 7'b1111111;				//output nothing
endcase
end	

endmodule