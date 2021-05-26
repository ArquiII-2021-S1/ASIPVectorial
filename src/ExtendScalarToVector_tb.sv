module ExtendScalarToVector_tb();
parameter N = 32, V=20;
logic [N-1:0] scalar_i;
logic [V-1:0][N-1:0] vector_o;

ExtendScalarToVector #(.N(N), .V(V)) DUT(.scalar_i(scalar_i),.vector_o(vector_o));

initial begin

scalar_i=1;
#5;
assert (vector_o[0] === 1) else $error("Case 1: failed.");
end




endmodule
