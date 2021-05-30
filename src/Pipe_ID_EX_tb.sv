module Pipe_ID_EX_tb ();

  parameter N = 32, V = 20;

  logic CLK, RST, enable_i;
  logic [N-1:0] RD1_S_i, RD2_S_i, Extend_i;
  logic RegFile_WE_i, ALUSource_i, SetFlags_i, MemWE_i, WBSelect_i, OpSource_i;
  logic [3:0] A3_i;
  logic [1:0] ALUControl_i, BranchSelect_i, OpType_i;
  logic [V-1:0][N-1:0] RD1_V_i, RD2_V_i;


  logic [N-1:0] RD1_S_o, RD2_S_o, Extend_o;
  logic RegFile_WE_o, ALUSource_o, SetFlags_o, MemWE_o, WBSelect_o, OpSource_o;
  logic [3:0] A3_o;
  logic [1:0] ALUControl_o, BranchSelect_o, OpType_o;
  logic [V-1:0][N-1:0] RD1_V_o, RD2_V_o;



  Pipe_ID_EX #(
      .N(N),
      .V(V)
  ) DUT (
      .CLK           (CLK),
      .RST           (RST),
      .enable_i      (enable_i),
      .RD1_S_i       (RD1_S_i),
      .RD2_S_i       (RD2_S_i),
      .Extend_i      (Extend_i),
      .RegFile_WE_i  (RegFile_WE_i),
      .ALUSource_i   (ALUSource_i),
      .SetFlags_i    (SetFlags_i),
      .MemWE_i       (MemWE_i),
      .WBSelect_i    (WBSelect_i),
      .OpSource_i    (OpSource_i),
      .A3_i          (A3_i),
      .ALUControl_i  (ALUControl_i),
      .BranchSelect_i(BranchSelect_i),
      .OpType_i      (OpType_i),
      .RD1_V_i       (RD1_V_i),
      .RD2_V_i       (RD2_V_i),
      .RD1_S_o       (RD1_S_o),
      .RD2_S_o       (RD2_S_o),
      .Extend_o      (Extend_o),
      .RegFile_WE_o  (RegFile_WE_o),
      .ALUSource_o   (ALUSource_o),
      .SetFlags_o    (SetFlags_o),
      .MemWE_o       (MemWE_o),
      .WBSelect_o    (WBSelect_o),
      .OpSource_o    (OpSource_o),
      .A3_o          (A3_o),
      .ALUControl_o  (ALUControl_o),
      .BranchSelect_o(BranchSelect_o),
      .OpType_o      (OpType_o),
      .RD1_V_o       (RD1_V_o),
      .RD2_V_o       (RD2_V_o)
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
    RD1_S_i = 3;
    enable_i = 0;
    #1 CLK = 1;
    #1;
    assert (RD1_S_o == 2)
    else $error("Case 3 failed.");


    #1 CLK = 0;
    enable_i = 1;
    RD1_S_i = 4;
    RST     = 1;
    #1 CLK = 1;
    #1;
    assert (RD1_S_o == 0)
    else $error("Case 4 failed.");

  end



endmodule
