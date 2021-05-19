module Counter_tb();

	logic clk, rst;
	logic [9:0] out;
	
	Counter #(10) counter(clk, rst, out);
	
	
	
	initial begin
		clk = 0;
		rst = 1;
		#10
		
		rst = 1;
		#10
		
		rst = 0;
		#50;
		
		rst = 1;
		#10;
		
		rst = 0;
	
	end
	
	always
		#5 clk = !clk;

endmodule 