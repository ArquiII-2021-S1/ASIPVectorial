module RdCounter(clk, rst, out);
	parameter N = 32;
	
	input logic clk, rst;
	output logic [N-1:0] out;
	
	// Initial value, in the next cycle it will be zero
	logic[N-1:0] qc = 0;
	
	always @ (posedge clk) begin
		if (rst)
			qc <= 0;
		else
			qc <= qc + 1;
	end
	
	assign out = qc;

endmodule 