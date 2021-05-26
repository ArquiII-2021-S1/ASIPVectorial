module ExtendScalarToVector #(parameter N = 32, V=20)(
						input logic [N-1:0] scalar_i,
						output logic [V-1:0][N-1:0] vector_o
						);


genvar i;
generate
for (i=0; i<V; i=i+1) begin: generate_vectors
		assign vector_o[i] = scalar_i;
end
endgenerate
endmodule