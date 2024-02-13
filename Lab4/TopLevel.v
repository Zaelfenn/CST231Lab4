module TopLevel(
input clk,
input ena,
input rst, 
input [3:0] cols,
output [3:0] rows, 
output [27:0] seven_segment,			//7 segments * 4 = 28 bits
output [1:0] led_out					//2 led's to turn on = 2 bits , led_out[0] = error, led_out[1] = no error
);

wire thousand_hertz, keypad_ena, one_hertz, shift_ena, shift_rst, val_rst, val_ena;
wire [3:0] keypad_out;
wire [3:0] shift_counter;
wire [2:0] val_counter;
wire [15:0] shift_out;


ClkDivider		#(100000, 17)		u1 (clk, rst, ena, thousand_hertz);				//1KHz
ClkDivider 								u2 (clk, rst, ena, one_hertz);					//1Hz

Counter			#(4)					c1 (one_hertz, shift_rst, shift_ena, shift_counter);
Counter			#(3)					c2 (one_hertz, val_rst, val_ena, val_counter);

keypad_check_sm 						sm1 (thousand_hertz, rst, cols, rows, keypad_out, keypad_ena);
shift_in_sm								sm2 (thousand_hertz, keypad_ena, keypad_out, shift_counter, shift_rst, shift_out, shift_ena);
valid_code_check_sm					sm3 (thousand_hertz, shift_ena, val_counter, shift_out, led_out[0], led_out[1], val_ena, val_rst);



endmodule