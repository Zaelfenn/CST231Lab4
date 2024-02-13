module Counter
		#(parameter BITS = 12)
(
input clk,								//clock input
input rst,								//active low reset
input ena, 								//active low enable
output reg [BITS-1:0] count				//counter output
);

always @ (negedge clk)
begin
	if (~rst)							//active low reset, set output to 0
		count <= 1'b0; 
	else if (~ena)						//active low enable, if it is not active, hold the count
		count <= count;
	else
		count <= count + 1'b1; 			//if enable and reset are both not active, add one to counter

end
endmodule