module MemStage(clk, rst, op_type, op_source, address, aluResultV, rd2_vec, aluResultS, rd2_sca, write_enable, scalar_output, vector_output, mem_finished);
	
	/* Parameters */
	parameter I = 20;  // Number of items in the vector
	parameter L = 8;  // Item length 
	parameter A = 6;   // Address length
	
	/* Input signals */
	input logic clk, rst, op_type, op_source, write_enable;
	input logic [A-1:0] address; 
	input logic [I-1:0][L-1:0] aluResultV, rd2_vec;
	input logic [L-1:0] aluResultS, rd2_sca;
	
	/* Output signals */
	output logic [I-1:0][L-1:0] vector_output;
	output logic [L-1:0] scalar_output;
	output logic mem_finished;
	
	/* ----------------------------------------------------------------------- */
	
	/* WriteModule signals */
	logic [I-1:0][L-1:0] wrSourceVec; // Write vector source
	logic [L-1:0] wrSourceSca;        // Write scalar source
	logic wrFinished;                 // Write finished signal
	logic [L-1:0] write_data;			 // Data to write in the memory
	logic [A-1:0] write_address;		 // Address to write
	
	/* WriteModule source muxes */
	assign wrSourceVec = op_source ? aluResultV : rd2_vec;
	assign wrSourceSca = op_source ? aluResultS : rd2_sca;
	
	WriteModule #(I,L,A) wrModule(
		.clk(clk), 
		.rst(rst), 
		.op_type(op_type), 
		.vector_data(wrSourceVec), 
		.scalar_data(wrSourceSca), 
		.base_address(address), 
		.write_data(write_data), 
		.write_address(write_address), 
		.finished(wrFinished)
	);
	
	/* ----------------------------------------------------------------------- */
	
	/* ReadModule Signals */
	logic [A-1:0] read_address; 
	logic rdFinished;
	
	ReadModule #(I,L,A) readModule(
		.clk(clk), 
		.rst(rst), 
		.op_type(op_type), 
		.base_address(address), 
		.read_data(read_data), 
		.read_address(read_address), 
		.scalar_data(scalar_output), 
		.vector_data(vector_output), 
		.finished(rdFinished)
	);
	
	/* ----------------------------------------------------------------------- */
	
	/* Memory Signals */
	logic [L-1:0] read_data;
	
	// Write enable
	logic wrEnable;
	assign weEnable = ~wrFinished && write_enable;
	
	
	
	assign mem_finished = (~write_enable && rdFinished) || (write_enable && wrFinished)
	
endmodule 