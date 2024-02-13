`timescale 1ns / 1ps

module valid_code_check_tb();

reg clk, enable;
reg [2:0] counter;
reg [15:0] din;

wire err, nerr, ena, rst;

valid_code_check_sm				t1(clk, enable, counter, din, err, nerr, ena, rst);

always
begin
	#10 clk <= ~clk;
end

initial
begin
counter <= 3'b000;
clk <= 1'b1;
enable <= 1'b1;
din <= 16'h1234;

#60 counter <= 3'b101;
#15 din <= 16'h258a;
	 counter <= 3'b000;
#55 counter <= 3'b101;
#15 din <= 16'habcd;
	 counter <= 3'b000;
#55 counter <= 3'b101;
#15 din <= 16'h1122;
	 counter <= 3'b000;
#55 counter <= 3'b101;
#15 din <= 16'h1010;
	 counter <= 3'b000;
#55 counter <= 3'b101;
#15 din <= 16'h123a;
	 counter <= 3'b000;
#55 counter <= 3'b101;
#15 din <= 16'h2580;
	 counter <= 3'b000;
#50 counter <= 3'b101;
end

endmodule