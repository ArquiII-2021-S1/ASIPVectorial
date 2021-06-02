module RdCounter (
    clk,
    rst,
    out
);
  parameter N = 32;

  input logic clk, rst;
  output logic [N-1:0] out;

  // Initial value, in the next cycle it will be zero
  logic [N-1:0] qc = 0;

  always @(posedge clk or posedge rst) begin
    if (rst == 0) begin
      qc <= qc + 1;
    end else begin
      qc <= 0;
    end
  end

  assign out = qc;

endmodule
