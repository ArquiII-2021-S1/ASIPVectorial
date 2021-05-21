module WriteModule(clk, rst, op_type, vector_data, scalar_data, base_address, write_data, write_address, finished);
	
	/* Parameters */
	parameter I = 20;  // Number of items in the vector
	parameter L = 32;  // Item length 
	parameter A = 10;  // Address length
	
	/* Input signals */
	input logic clk, op_type, rst;
	input logic [A-1:0] base_address;
	input logic [I-1:0][L-1:0] vector_data;
	input logic [L-1:0] scalar_data;
	
	/* Output signals */
	output logic [A-1:0] write_address;
	output logic [L-1:0] write_data;
	output finished;
	
	/* Internal signals */
	logic [A-1:0] counter;
	logic [L-1:0] v_item;
	logic [A-1:0] v_address;
	
	// Calculate the write address
	Counter #(A) cntr(clk, rst, counter);
	
	// Calculate vector write address 
	assign v_address = counter + base_address;
	
	// Vector item extraction
	VectorItemExtractor #(I,L) vectorExtractor(vector_data, counter, v_item);
	
	// Selection between vector item and scalar data
	assign write_data = op_type ? v_item : scalar_data;
	
	// Selection between vector write address and scalar write address
	assign write_address = op_type ? v_address : base_address; 

	// Finished signal
	FinishedSignal #(A) finish(clk, rst, op_type, counter, finished);
	
endmodule 