module WriteModule_tb();

	logic clk, op_type, rst;
	logic [5:0] base_address;
	logic [19:0][9:0] vector_data;
	logic [9:0] scalar_data;
	
	logic [5:0] write_address;
	logic [9:0] write_data;
	
	
	WriteModule #(20,10,6) wrModule(
		.clk(clk), 
		.rst(rst), 
		.op_type(op_type), 
		.vector_data(vector_data), 
		.scalar_data(scalar_data),
		.base_address(base_address), 
		.write_data(write_data), 
		.write_address(write_address)
	);
	

	initial begin
		clk = 1;
		rst = 0;
		
		base_address = 6'd34;
		
		scalar_data = 10'd160;
		
		vector_data[0]  = 10'd50;
		vector_data[1]  = 10'd51;
		vector_data[2]  = 10'd52;
		vector_data[3]  = 10'd53;
		vector_data[4]  = 10'd54;
		vector_data[5]  = 10'd55;
		vector_data[6]  = 10'd56;
		vector_data[7]  = 10'd57;
		vector_data[8]  = 10'd58;
		vector_data[9]  = 10'd59;
		vector_data[10] = 10'd60;
		vector_data[11] = 10'd61;
		vector_data[12] = 10'd62;
		vector_data[13] = 10'd63;
		vector_data[14] = 10'd64;
		vector_data[15] = 10'd65;
		vector_data[16] = 10'd66;
		vector_data[17] = 10'd67;
		vector_data[18] = 10'd68;
		vector_data[19] = 10'd69;
		
		op_type = 0;
		#10;
		
		// Case 1
		assert(write_address === base_address) else $error("Case 1: Write Address failed");
		assert(write_data === scalar_data) else $error("Case 1: Write Data failed");
		
		op_type = 1;
		#10;
		
		// Case 2
		assert(write_address === (base_address+6'd1)) else $error("Case 2: Write Address failed");
		assert(write_data === vector_data[1]) else $error("Case 2: Write Data failed");
		#10;
		
		// Case 3
		assert(write_address === (base_address+6'd2)) else $error("Case 3: Write Address failed");
		assert(write_data === vector_data[2]) else $error("Case 3: Write Data failed");
		#10;
		
		// Case 4
		assert(write_address === (base_address+6'd3)) else $error("Case 4: Write Address failed");
		assert(write_data === vector_data[3]) else $error("Case 4: Write Data failed");
		#10;
		
		// Case 5
		assert(write_address === (base_address+6'd4)) else $error("Case 5: Write Address failed");
		assert(write_data === vector_data[4]) else $error("Case 5: Write Data failed");
		
		rst = 1;
		#10;
		rst = 0;
		
		// Case 6
		assert(write_address === base_address) else $error("Case 6: Write Address failed");
		assert(write_data === vector_data[0]) else $error("Case 6: Write Data failed");
		#10;
		
		// Case 7
		assert(write_address === (base_address+6'd1)) else $error("Case 7: Write Address failed");
		assert(write_data === vector_data[1]) else $error("Case 7: Write Data failed");
		
		op_type = 0;
		#10;
		
		// Case 8
		assert(write_address === base_address) else $error("Case 8: Write Address failed");
		assert(write_data === scalar_data) else $error("Case 8: Write Data failed");
		#10;

	end
	
	always
		#5 clk = !clk;


endmodule 