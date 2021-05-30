module Execute_Stage_ready #(
    N=32
) (
    OpType_i,
    fork_ready_i,
    ready_o
);
input logic [1:0] OpType_i;
input logic fork_ready_i;
output logic ready_o;

assign ready_o = OpType_i[1]? fork_ready_i:1;

endmodule