module Pipe_EX_MEM #(
    N = 32,
    V = 20,
    L = 8

) (
    CLK,
    RST,
    enable_i,

    A3_i,
    MemWE_i,
    OpSource_i,
    OpType_i,
    RD1_S_i,
    RD1_V_i,
    RD2_S_i,
    RD2_V_i,
    RegFile_WE_i,
    WBSelect_i,
    AluResult_S_i,
    AluResult_V_i,

    A3_o,
    MemWE_o,
    OpSource_o,
    OpType_o,
    RD1_S_o,
    RD1_V_o,
    RD2_S_o,
    RD2_V_o,
    RegFile_WE_o,
    WBSelect_o,
    AluResult_S_o,
    AluResult_V_o


);


  input logic CLK, RST, enable_i;

  input logic [N-1:0] RD1_S_i, RD2_S_i, AluResult_S_i;
  input logic RegFile_WE_i, MemWE_i, WBSelect_i, OpSource_i;
  input logic [4:0] A3_i;
  input logic [1:0] OpType_i;
  input logic [V-1:0][L-1:0] RD1_V_i, RD2_V_i, AluResult_V_i;

  output logic [N-1:0] RD1_S_o, RD2_S_o, AluResult_S_o;
  output logic RegFile_WE_o, MemWE_o, WBSelect_o, OpSource_o;
  output logic [4:0] A3_o;
  output logic [1:0] OpType_o;
  output logic [V-1:0][L-1:0] RD1_V_o, RD2_V_o, AluResult_V_o;

  always @(posedge CLK)
    if (RST) begin
      A3_o <= 0;
      MemWE_o <= 0;
      OpSource_o <= 0;
      OpType_o <= 0;
      RD1_S_o <= 0;
      RD1_V_o <= 0;
      RD2_S_o <= 0;
      RD2_V_o <= 0;
      RegFile_WE_o <= 0;
      WBSelect_o <= 0;
      AluResult_S_o <= 0;
      AluResult_V_o <= 0;
    end else begin
      if (enable_i) begin
        A3_o <= A3_i;
        MemWE_o <= MemWE_i;
        OpSource_o <= OpSource_i;
        OpType_o <= OpType_i;
        RD1_S_o <= RD1_S_i;
        RD1_V_o <= RD1_V_i;
        RD2_S_o <= RD2_S_i;
        RD2_V_o <= RD2_V_i;
        RegFile_WE_o <= RegFile_WE_i;
        WBSelect_o <= WBSelect_i;
        AluResult_S_o <= AluResult_S_i;
        AluResult_V_o <= AluResult_V_i;
      end

    end

endmodule
