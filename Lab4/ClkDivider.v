module ClkDivider 
					#(parameter DIVIDER = 12500000,
									BITS = 25)							//default 1 second clock
					 (input clk,										//system clock input, 50MHz
					  input rst, 										//active low reset
					  input ena, 										//active low enable
					  output reg clk_out);							//clock out signal

	reg [BITS-1:0] count;											//variable bit counter can divide clock as needed, default up to approx. one second
			
			
always @ (negedge clk or negedge rst)
begin
	if (~rst)
	begin
		clk_out <= 1'b0;												//if resetting, keep clock output low
	end
	else if (ena)
		begin																//if enable isn't active, hold the value
			clk_out <= clk_out;
		end
	else if (count < DIVIDER)										//if the count has not yet hit the parameter for division, keep output the same
	begin
		clk_out <= clk_out;
	end
	else
	begin
		clk_out <= ~clk_out;											//otherwise, invert the output
	end
end
				
always @ (negedge clk or negedge rst)
begin
	if (~rst)
	begin
		count = 0;														//if resetting, reset count
	end
	else if (ena)
		begin																//if enable isn't active, hold the value
			count <= count;
		end
	else if (count < DIVIDER)										//if the count has not yet hit the parameter for division, add one to it
	begin
		count <= count + 1;
	end
	else
	begin
		count <= 0;														//otherwise, reset the count
	end

end			
					  

endmodule