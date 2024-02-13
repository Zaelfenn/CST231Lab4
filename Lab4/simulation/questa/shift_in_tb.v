`timescale 1ns / 1ps

module shift_in_tb();

reg clk, enable;
reg [3:0] din;
reg [4:0] counter;

wire rst, ena;
wire [15:0] dout;


shift_in_sm			t1(clk, enable, din, counter, rst, dout, ena);

always
begin
	#10 clk <= ~clk;
end

initial
begin
din <= 4'b0101;
enable <= 1'b1;
counter <= 4'h0;
clk <= 1'b1;
#35 enable <= 1'b0;
    din <= 4'b1001;
#25 enable <= 1'b1;
#30 din <= 4'b0110;
#20 din <= 4'b1010;
#15 din <= 4'b1111;

end
endmodule