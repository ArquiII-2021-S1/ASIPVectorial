module Pipe_IF_ID #(
    N = 32
) (
    CLK,
    RST,
    enable_i,
    instruction_i,
    instruction_o
);
  input logic CLK, RST, enable_i;
  input logic [N-1:0] instruction_i;
  output logic [N-1:0] instruction_o;
  //logic [N-1:0] instruction;



  always @(posedge CLK) begin
    if (RST) begin
      instruction_o <= 0;
    end else begin
      if (enable_i) begin
        instruction_o <= instruction_i;
      end
    end
  end
endmodule
