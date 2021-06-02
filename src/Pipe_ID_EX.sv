module Pipe_ID_EX #(
    N = 32,
    V = 20,
    L = 8
) (
    CLK,
    RST,
    enable_i,

    A3_i,
    ALUControl_i,
    ALUSource_i,
    BranchSelect_i,
    Extend_i,
    MemWE_i,
    OpSource_i,
    OpType_i,
    RD1_S_i,
    RD1_V_i,
    RD2_S_i,
    RD2_V_i,
    RegFile_WE_i,
    SetFlags_i,
    WBSelect_i,

    A3_o,
    ALUControl_o,
    ALUSource_o,
    BranchSelect_o,
    Extend_o,
    MemWE_o,
    OpSource_o,
    OpType_o,
    RD1_S_o,
    RD1_V_o,
    RD2_S_o,
    RD2_V_o,
    RegFile_WE_o,
    SetFlags_o,
    WBSelect_o
);

  input logic CLK, RST, enable_i;
  input logic [N-1:0] RD1_S_i, RD2_S_i, Extend_i;
  input logic RegFile_WE_i, ALUSource_i, SetFlags_i, MemWE_i, WBSelect_i, OpSource_i;
  input logic [4:0] A3_i;
  input logic [1:0] ALUControl_i, BranchSelect_i, OpType_i;
  input logic [V-1:0][L-1:0] RD1_V_i, RD2_V_i;


  output logic [N-1:0] RD1_S_o, RD2_S_o, Extend_o;
  output logic RegFile_WE_o, ALUSource_o, SetFlags_o, MemWE_o, WBSelect_o, OpSource_o;
  output logic [4:0] A3_o;
  output logic [1:0] ALUControl_o, BranchSelect_o, OpType_o;
  output logic [V-1:0][L-1:0] RD1_V_o, RD2_V_o;


  always @(posedge CLK) begin
    if (RST) begin
      RD1_S_o <= 0;
      RD2_S_o <= 0;
      RD1_V_o <= 0;
      RD2_V_o <= 0;
      WBSelect_o <= 0;
      MemWE_o <= 0;
      ALUControl_o <= 0;
      OpType_o <= 0;
      RegFile_WE_o <= 0;
      ALUSource_o <= 0;
      OpSource_o <= 0;
      Extend_o <= 0;
      A3_o <= 0;
      BranchSelect_o <= 0;
      SetFlags_o <= 0;
    end else begin
      if (enable_i) begin
        RD1_S_o        <= RD1_S_i;
        RD2_S_o        <= RD2_S_i;
        RD1_V_o        <= RD1_V_i;
        RD2_V_o        <= RD2_V_i;
        WBSelect_o     <= WBSelect_i;
        MemWE_o        <= MemWE_i;
        ALUControl_o   <= ALUControl_i;
        OpType_o       <= OpType_i;
        RegFile_WE_o   <= RegFile_WE_i;
        ALUSource_o    <= ALUSource_i;
        OpSource_o     <= OpSource_i;
        Extend_o       <= Extend_i;
        A3_o           <= A3_i;
        BranchSelect_o <= BranchSelect_i;
        SetFlags_o     <= SetFlags_i;
      end

    end
  end
endmodule
