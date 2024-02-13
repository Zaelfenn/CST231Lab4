module BCDDec(
   input [15:0] bin,									//max value is 32767
   output reg [19:0] bcd							//32767 is 5 digits, 5 * 4 is 20, therefore 20 bit register output
   );
   
integer i;
	
always @(bin) begin
    bcd=0;		 	
    for (i=0;i<15;i=i+1) begin					//Iterate once for each bit in input number
		if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three, 5 shifted over is 9 (at least), and three shifted
		if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;		//over by one is 6, which finishes the conversion
		if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
		if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
	
	bcd = {bcd[18:0],bin[15-i]};				//Shift one bit, and shift in proper bit from input 
    end
end
endmodule
