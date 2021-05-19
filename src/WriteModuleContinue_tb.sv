module WriteModuleContinue_tb();

	logic op_type;
	logic [9:0] base_address, write_address;
	logic write_done;

	WriteModuleContinue #(10) wrContinue(
		.base_address(base_address), 
		.write_address(write_address), 
		.op_type(op_type), 
		.write_done(write_done)
	);	
	
	initial begin
		// Case 1: scalar write
		base_address = 10'd573;
		write_address = 10'd573;
		op_type = 1'b0;
		
		#10;
		assert(write_done === 1'b1) else $error("Case 1 Failed");
		
		
		// Case 2: vector write
		op_type = 1'b1;
		#10;
		assert(write_done === 1'b0) else $error("Case 2 Failed");
		
		// Case 3: vector write
		op_type = 1'b1;
		write_address = 10'd582;
		#10;
		assert(write_done === 1'b0) else $error("Case 3 Failed");
	
		// Case 4: vector write
		op_type = 1'b1;
		write_address = 10'd592;
		#10;
		assert(write_done === 1'b0) else $error("Case 4 Failed");
		
		// Case 5: vector write
		op_type = 1'b1;
		write_address = 10'd593;
		#10;
		assert(write_done === 1'b1) else $error("Case 5 Failed");
	
	
	end
	
endmodule 