`timescale 1ns / 1ps

module SevenSeg_tb();

reg [3:0] q;
wire [6:0] light;

SevenSegDecoder			t1 (q, light);

always 
begin
	#10 q <= q + 1;
end

initial
begin
	q <= 4'b0000;
end
endmodule
