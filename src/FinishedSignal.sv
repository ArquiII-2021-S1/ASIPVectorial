module FinishedSignal(clk, rst, op_type, counter, finished);
	
	/* Parameters */
	parameter N = 6;  // Address length
	
	/* Input signals */
	input logic clk, rst, op_type;
	input logic [N-1:0] counter;
	
	/* Output signals */
	output logic finished;
	
	initial begin
		finished <= 0;
	end
	
	logic A, B;
	assign A = counter === 6'd20;
	assign B = counter === 6'd1;
	
	logic trigger;
	assign trigger = (B && ~op_type) || (A && op_type);
	
	always @(posedge clk) begin
		if (rst) finished <= 0;
		
		else if (trigger) begin
			finished <= 1;
		end
	end
	
endmodule 