module VectorItemExtractor_tb();

	logic [4:0] address;
	logic [19:0][9:0] vector;
	logic [9:0] item;

	VectorItemExtractor #(20, 10) viEx(vector, address, item);
	
	initial begin
		vector[0] = 10'd50;
		vector[1] = 10'd51;
		vector[2] = 10'd52;
		vector[3] = 10'd35;

		// Case 1
		address = 5'd0;
		#10;
		assert(item === 10'd50) else $error("Case 1 failed");
		
		// Case 2
		address = 5'd1;
		#10;
		assert(item === 10'd51) else $error("Case 2 failed");
		
		// Case 3
		address = 5'd2;
		#10;
		assert(item === 10'd52) else $error("Case 3 failed");
		
		// Case 4
		address = 5'd3;
		#10;
		assert(item === 10'd35) else $error("Case 4 failed");
		
	end
	
endmodule 