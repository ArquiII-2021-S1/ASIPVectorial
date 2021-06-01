module Pipe_MEM_WB_tb ();

  parameter N = 32, V = 20;

  logic CLK, RST, enable_i;
  logic [N-1:0] Data_Mem_S_i, Data_Result_S_i;
  logic RegFile_WE_i, WBSelect_i;
  logic [3:0] A3_i;
  logic [1:0] OpType_i;
  logic [V-1:0][N-1:0] Data_Mem_V_i, Data_Result_V_i;
  logic [N-1:0] Data_Mem_S_o, Data_Result_S_o;
  logic RegFile_WE_o, WBSelect_o;
  logic [3:0] A3_o;
  logic [1:0] OpType_o;
  logic [V-1:0][N-1:0] Data_Mem_V_o, Data_Result_V_o;

  Pipe_MEM_WB #(
      .N(N),
      .V(V)
  ) u_Pipe_MEM_WB (
      .CLK            (CLK),
      .RST            (RST),
      .enable_i       (enable_i),
      .Data_Mem_S_i   (Data_Mem_S_i),
      .Data_Result_S_i(Data_Result_S_i),
      .RegFile_WE_i   (RegFile_WE_i),
      .WBSelect_i     (WBSelect_i),
      .A3_i           (A3_i),
      .OpType_i       (OpType_i),
      .Data_Mem_V_i   (Data_Mem_V_i),
      .Data_Result_V_i(Data_Result_V_i),
      .Data_Mem_S_o   (Data_Mem_S_o),
      .Data_Result_S_o(Data_Result_S_o),
      .RegFile_WE_o   (RegFile_WE_o),
      .WBSelect_o     (WBSelect_o),
      .A3_o           (A3_o),
      .OpType_o       (OpType_o),
      .Data_Mem_V_o   (Data_Mem_V_o),
      .Data_Result_V_o(Data_Result_V_o)
  );



  initial begin
    CLK      = 0;

    RST      = 1;
    enable_i = 1;
    #1 CLK = 1;

    RST = 0;


    #1 CLK = 0;
    Data_Mem_S_i = 1;
    #1 CLK = 1;
    #1;
    assert (Data_Mem_S_o == Data_Mem_S_i)
    else $error("Case 1 failed.");
    #1;


    #1 CLK = 0;
    Data_Mem_S_i = 2;
    #1 CLK = 1;
    #1;
    assert (Data_Mem_S_o == Data_Mem_S_i)
    else $error("Case 2 failed.");


    #1 CLK = 0;
    Data_Mem_S_i = 3;
    enable_i = 0;
    #1 CLK = 1;
    #1;
    assert (Data_Mem_S_o == 2)
    else $error("Case 3 failed.");


    #1 CLK = 0;
    enable_i = 1;
    Data_Mem_S_i = 4;
    RST     = 1;
    #1 CLK = 1;
    #1;
    assert (Data_Mem_S_o == 0)
    else $error("Case 4 failed.");

  end





endmodule
