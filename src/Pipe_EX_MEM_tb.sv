module Pipe_EX_MEM_tb ();

  parameter N = 32, V = 20;

  logic CLK, RST, enable_i;
  logic [N-1:0] RD1_S_i, RD2_S_i, AluResult_S_i;
  logic RegFile_WE_i, MemWE_i, WBSelect_i, OpSource_i;
  logic [3:0] A3_i;
  logic [1:0] OpType_i;
  logic [V-1:0][N-1:0] RD1_V_i, RD2_V_i, AluResult;

  logic [N-1:0] RD1_S_o, RD2_S_o, AluResult_S_o;
  logic RegFile_WE_o, MemWE_o, WBSelect_o, OpSource_o;
  logic [3:0] A3_o;
  logic [1:0] OpType_o;
  logic [V-1:0][N-1:0] RD1_V_o, RD2_V_o, AluResult_V_o;


  Pipe_EX_MEM #(
      .N(N),
      .V(V)
  ) u_Pipe_EX_MEM (
      .CLK          (CLK),
      .RST          (RST),
      .enable_i     (enable_i),
      .RD1_S_i      (RD1_S_i),
      .RD2_S_i      (RD2_S_i),
      .AluResult_S_i(AluResult_S_i),
      .RegFile_WE_i (RegFile_WE_i),
      .MemWE_i      (MemWE_i),
      .WBSelect_i   (WBSelect_i),
      .OpSource_i   (OpSource_i),
      .A3_i         (A3_i),
      .OpType_i     (OpType_i),
      .RD1_V_i      (RD1_V_i),
      .RD2_V_i      (RD2_V_i),
      .AluResult_V_i(AluResult_V_i),
      .RD1_S_o      (RD1_S_o),
      .RD2_S_o      (RD2_S_o),
      .AluResult_S_o(AluResult_S_o),
      .RegFile_WE_o (RegFile_WE_o),
      .MemWE_o      (MemWE_o),
      .WBSelect_o   (WBSelect_o),
      .OpSource_o   (OpSource_o),
      .A3_o         (A3_o),
      .OpType_o     (OpType_o),
      .RD1_V_o      (RD1_V_o),
      .RD2_V_o      (RD2_V_o),
      .AluResult_V_o(AluResult_V_o)
  );


  initial begin
    CLK      = 0;

    RST      = 1;
    enable_i = 1;
    #1 CLK = 1;

    RST = 0;


    #1 CLK = 0;
    RD1_S_i = 1;
    #1 CLK = 1;
    #1;
    assert (RD1_S_o == RD1_S_i)
    else $error("Case 1 failed.");
    #1;


    #1 CLK = 0;
    RD1_S_i = 2;
    #1 CLK = 1;
    #1;
    assert (RD1_S_o == RD1_S_i)
    else $error("Case 2 failed.");


    #1 CLK = 0;
    RD1_S_i  = 3;
    enable_i = 0;
    #1 CLK = 1;
    #1;
    assert (RD1_S_o == 2)
    else $error("Case 3 failed.");


    #1 CLK = 0;
    enable_i = 1;
    RD1_S_i  = 4;
    RST      = 1;
    #1 CLK = 1;
    #1;
    assert (RD1_S_o == 0)
    else $error("Case 4 failed.");

  end
endmodule
