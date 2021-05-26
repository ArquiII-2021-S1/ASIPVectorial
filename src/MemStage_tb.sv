`timescale 1 ps / 1 ps

module MemStage_tb();
	/* Input signals */
	logic clk, rst, op_type, op_source, write_enable;
	logic [15:0] address; 
	logic [19:0][7:0] aluResultV, rd2_vec;
	logic [7:0] aluResultS, rd2_sca;
	
	/* Output signals */
	logic [19:0][7:0] vector_output;
	logic [7:0] scalar_output, mem_data;
	logic mem_finished;
	
	MemStage mem_stage(
		.clk(clk), 
		.rst(rst), 
		.op_type(op_type), 
		.op_source(op_source), 
		.address(address), 
		.aluResultV(aluResultV), 
		.rd2_vec(rd2_vec), 
		.aluResultS(aluResultS), 
		.rd2_sca(rd2_sca), 
		.write_enable(write_enable), 
		.scalar_output(scalar_output), 
		.vector_output(vector_output), 
		.mem_finished(mem_finished), 
		.mem_data(mem_data)
	);

	initial begin
		clk = 1;
		rst = 1;
		op_type = 0;
		write_enable = 0;
		address = 0;
		op_source = 0;
		
		// Scalar data
		aluResultS = 8'd40;
		rd2_sca = 8'd25;
		
		// Vector data
		aluResultV[0]  = 8'd50;
		aluResultV[1]  = 8'd51;
		aluResultV[2]  = 8'd52;
		aluResultV[3]  = 8'd53;
		aluResultV[4]  = 8'd54;
		aluResultV[5]  = 8'd55;
		aluResultV[6]  = 8'd56;
		aluResultV[7]  = 8'd57;
		aluResultV[8]  = 8'd58;
		aluResultV[9]  = 8'd59;
		aluResultV[10] = 8'd60;
		aluResultV[11] = 8'd61;
		aluResultV[12] = 8'd62;
		aluResultV[13] = 8'd63;
		aluResultV[14] = 8'd64;
		aluResultV[15] = 8'd65;
		aluResultV[16] = 8'd66;
		aluResultV[17] = 8'd67;
		aluResultV[18] = 8'd68;
		aluResultV[19] = 8'd69;
		
		// Vector data
		rd2_vec[0]  = 8'd100;
		rd2_vec[1]  = 8'd101;
		rd2_vec[2]  = 8'd102;
		rd2_vec[3]  = 8'd103;
		rd2_vec[4]  = 8'd104;
		rd2_vec[5]  = 8'd105;
		rd2_vec[6]  = 8'd106;
		rd2_vec[7]  = 8'd107;
		rd2_vec[8]  = 8'd108;
		rd2_vec[9]  = 8'd109;
		rd2_vec[10] = 8'd110;
		rd2_vec[11] = 8'd111;
		rd2_vec[12] = 8'd112;
		rd2_vec[13] = 8'd113;
		rd2_vec[14] = 8'd114;
		rd2_vec[15] = 8'd115;
		rd2_vec[16] = 8'd116;
		rd2_vec[17] = 8'd117;
		rd2_vec[18] = 8'd118;
		rd2_vec[19] = 8'd119;
		#10;

		
		rst = 0;
		op_source = 1'd0; // Register data
		op_type = 1'd0; // Scalar data 
		write_enable = 1'd1;
		#250
		address = 16'd0;
		write_enable = 1'd0;
		rst=1;
		#10;
		rst = 0;
		
	end
	
	always
		#5 clk = !clk;
	
	
endmodule 