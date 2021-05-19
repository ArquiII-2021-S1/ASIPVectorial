module WriteModuleContinue(base_address, write_address, op_type, write_done);
	parameter N = 10;
	
	input logic op_type;
	input logic[N-1:0] base_address, write_address;
	output logic write_done;
	
	logic vec_comp;
	
	assign vec_comp = (write_address > (base_address+5'd19));
	
	assign write_done = vec_comp || (~op_type);

endmodule 