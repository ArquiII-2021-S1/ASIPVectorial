module WriteEnable_tb();

	logic op_type, we_control_unit;
	logic[9:0] base_address, write_address;
	logic write_enable;

	WriteEnable #(10) writeEnable(
		.op_type(op_type), 
		.base_address(base_address), 
		.write_address(write_address),
		.we_control_unit(we_control_unit), 
		.write_enable(write_enable)
	);
	
	initial begin
		op_type = 1'b0;
		we_control_unit = 1'b0;
		base_address = 10'd354;
		write_address = 10'd354;
		#10;
		
		// Case 1: scalar write, not enabled
		assert(write_enable === 1'b0) else $error("Case 1 failed");
		
		// Case 2: scalar write, enabled
		we_control_unit = 1'b1;
		#10;
		assert(write_enable === 1'b1) else $error("Case 2 failed");
		
		// Case 3: vector write, enabled
		op_type = 1'b1;
		#10;
		assert(write_enable === 1'b1) else $error("Case 3 failed");
		
		// Case 4: vector write, enabled
		write_address = 10'd373;
		#10;
		assert(write_enable === 1'b1) else $error("Case 4 failed");
		
		// Case 5: vector write, address not valid 
		write_address = 10'd374;
		#10;
		assert(write_enable === 1'b0) else $error("Case 5 failed");
		
		
	end
	
endmodule 