module Execute_Stage_ready #(
    N=32
) (
    OpType_i,
    counter_i,
    ready_o
);
input logic [1:0] OpType_i;
input integer counter_i;
output logic ready_o;

logic temp;
assign temp = (counter_i==4);
assign ready_o = OpType_i? temp:1;

endmodule