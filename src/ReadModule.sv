module ReadModule(clk, rst, op_type, base_address, read_data, read_address, scalar_data, vector_data, finished);
	
	/* Parameters */
	parameter I = 20;  // Number of items in the vector
	parameter L = 32;  // Item length 
	parameter A = 6;   // Address length
	
	/* Input signals */
	input logic clk, rst, op_type;
	input logic [A-1:0] base_address;
	input logic [L-1:0] read_data;
	
	/* Output signals */
	output logic [A-1:0] read_address;
	output logic [L-1:0] scalar_data;
	output logic [I-1:0][L-1:0] vector_data;
	output logic finished;
	
	initial begin
		vector_data <= 0;
		finished <= 0;
	end
	
	/* Internal signals */
	logic [A-1:0] counter;
	
	// Calculates the read offset
	Counter #(A) cntr(clk, rst, counter);
	
	// Calculates read address 
	assign read_address = counter + base_address;
	
	// Stores the read data
	always_ff @(negedge clk) begin
		case (counter)
			5'd0  : vector_data[0]  <= read_data;
			5'd1  : vector_data[1]  <= read_data;
			5'd2  : vector_data[2]  <= read_data;
			5'd3  : vector_data[3]  <= read_data;
			5'd4  : vector_data[4]  <= read_data;
			5'd5  : vector_data[5]  <= read_data;
			5'd6  : vector_data[6]  <= read_data;
			5'd7  : vector_data[7]  <= read_data;
			5'd8  : vector_data[8]  <= read_data;
			5'd9  : vector_data[9]  <= read_data;
			5'd10 : vector_data[10] <= read_data;
			5'd11 : vector_data[11] <= read_data;
			5'd12 : vector_data[12] <= read_data;
			5'd13 : vector_data[13] <= read_data;
			5'd14 : vector_data[14] <= read_data;
			5'd15 : vector_data[15] <= read_data;
			5'd16 : vector_data[16] <= read_data;
			5'd17 : vector_data[17] <= read_data;
			5'd18 : vector_data[18] <= read_data;
			default : vector_data[19] <= read_data;
		endcase
	end
	
	assign scalar_data = vector_data[0];

	// Finished signal
	FinishedSignal #(A) finish(clk, rst, op_type, counter, finished);

endmodule 