module Pipe_MEM_WB #(
    N = 32,
    V = 20
) (
    CLK,
    RST,
    enable_i,

    A3_i,
    Data_Mem_S_i,
    Data_Mem_V_i,
    Data_Result_S_i,
    Data_Result_V_i,
    OpType_i,
    RegFile_WE_i,
    WBSelect_i,

    A3_o,
    Data_Mem_S_o,
    Data_Mem_V_o,
    Data_Result_S_o,
    Data_Result_V_o,
    OpType_o,
    RegFile_WE_o,
    WBSelect_o

);


  input logic CLK, RST, enable_i;

  input logic [N-1:0] Data_Mem_S_i, Data_Result_S_i;
  input logic RegFile_WE_i, WBSelect_i;
  input logic [3:0] A3_i;
  input logic [1:0] OpType_i;
  input logic [V-1:0][N-1:0] Data_Mem_V_i, Data_Result_V_i;


  output logic [N-1:0] Data_Mem_S_o, Data_Result_S_o;
  output logic RegFile_WE_o, WBSelect_o;
  output logic [3:0] A3_o;
  output logic [1:0] OpType_o;
  output logic [V-1:0][N-1:0] Data_Mem_V_o, Data_Result_V_o;

  always @(posedge CLK)
    if (RST) begin
      A3_o <= 0;
      Data_Mem_S_o <= 0;
      Data_Mem_V_o <= 0;
      Data_Result_S_o <= 0;
      Data_Result_V_o <= 0;
      OpType_o <= 0;
      RegFile_WE_o <= 0;
      WBSelect_o <= 0;
    end else begin
      if (enable_i) begin
        A3_o <= A3_i;
        Data_Mem_S_o <= Data_Mem_S_i;
        Data_Mem_V_o <= Data_Mem_V_i;
        Data_Result_S_o <= Data_Result_S_i;
        Data_Result_V_o <= Data_Result_V_i;
        OpType_o <= OpType_i;
        RegFile_WE_o <= RegFile_WE_i;
        WBSelect_o <= WBSelect_i;
      end
    end
endmodule
