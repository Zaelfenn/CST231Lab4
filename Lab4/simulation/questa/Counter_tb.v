`timescale 1ns / 1ps

module Counter_tb();

reg clk, rst, ena, u_d;
wire [11:0] count;

Counter 	T1 (clk, rst, ena, u_d, count);

always
	#10 clk <= ~clk;
	
initial 
begin
	clk <= 0;
	rst <= 0;
	ena <= 0;
	u_d <= 1;
	#10 rst <= 1;
	#90 rst <= 0;
	#10 rst <= 1;
	#10 ena <= 1;
	#10 ena <= 0;
	#50 u_d <= 0;
	#100 rst <= 0;
end

endmodule
