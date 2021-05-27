module ForkVector #(parameter N = 32, V=20)(
						input logic CLK,
						input logic RST,
						input logic[1:0] OpType,
						input logic 	[V-1:0][N-1:0] RD1_VEC_i,
						input logic 	[V-1:0][N-1:0] RD2_VEC_i,
						input logic 	[N-1:0] Scalar_i,
						output logic 	[4-1:0][N-1:0] Vec_A_o,
						output logic 	[4-1:0][N-1:0] Vec_B_o,
						output integer counter=0
						);



assign Vec_A_o[0] = RD1_VEC_i[counter];
assign Vec_A_o[1] = RD1_VEC_i[5+counter];
assign Vec_A_o[2] = RD1_VEC_i[10+counter];
assign Vec_A_o[3] = RD1_VEC_i[15+counter];
assign Vec_B_o[0] = OpType[0]? RD2_VEC_i[counter]:Scalar_i;
assign Vec_B_o[1] = OpType[0]? RD2_VEC_i[5+counter]:Scalar_i;
assign Vec_B_o[2] = OpType[0]? RD2_VEC_i[10+counter]:Scalar_i;
assign Vec_B_o[3] = OpType[0]? RD2_VEC_i[15+counter]:Scalar_i;


always @(negedge (CLK))begin
	if (RST == 0)begin
		counter=counter+1;
		if (counter==5) begin
			counter=0;
		end
	end
	else begin
		counter=0;
		end
end



//genvar i;
//generate
//for (i=0; i<V; i=i+1) begin: generate_vectors
//		assign vector_o[i] = scalar_i;
//end
//endgenerate
endmodule