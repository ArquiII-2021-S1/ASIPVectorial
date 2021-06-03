`timescale 1 ps / 1 ps
module Stage_Memory_tb ();
  parameter N = 32, L = 8, A = 32, V = 20, I = 20;


  logic RST_memStage;


  logic CLK;
  logic RST;
  logic enable_i;

    logic [31:0] BASE_ADDRESS=32'h10000;

  logic MEM_ready;
  logic [L-1:0] MEM_data_out;


  logic [N-1:0] RD1_S_EX, RD2_S_EX, AluResult_S_EX;
  logic RegFile_WE_EX, MemWE_EX, WBSelect_EX, OpSource_EX;
  logic [3:0] A3_EX;
  logic [1:0] OpType_EX;
  logic [V-1:0][L-1:0] RD1_V_EX, RD2_V_EX, AluResult_V_EX;

  logic [N-1:0] RD1_S_MEM, RD2_S_MEM, AluResult_S_MEM;
  logic RegFile_WE_MEM, MemWE_MEM, WBSelect_MEM, OpSource_MEM;
  logic [3:0] A3_MEM;
  logic [1:0] OpType_MEM;
  logic [V-1:0][L-1:0] RD1_V_MEM, RD2_V_MEM, AluResult_V_MEM;
  logic [N-1:0] Data_Mem_S_MEM, Data_Result_S_MEM;
  logic [V-1:0][L-1:0] Data_Mem_V_MEM, Data_Result_V_MEM;


  logic [N-1:0] Data_Mem_S_WB, Data_Result_S_WB;
  logic RegFile_WE_WB, WBSelect_WB;
  logic [3:0] A3_WB;
  logic [1:0] OpType_WB;
  logic [V-1:0][L-1:0] Data_Mem_V_WB, Data_Result_V_WB;

  Pipe_EX_MEM #(
      .N(N),
      .V(V),
      .L(L)
  ) u_Pipe_EX_MEM (
      .CLK     (CLK),
      .RST     (RST),
      .enable_i(enable_i),

      .RD1_S_i      (RD1_S_EX),
      .RD2_S_i      (RD2_S_EX),
      .AluResult_S_i(AluResult_S_EX),
      .RegFile_WE_i (RegFile_WE_EX),
      .MemWE_i      (MemWE_EX),
      .WBSelect_i   (WBSelect_EX),
      .OpSource_i   (OpSource_EX),
      .A3_i         (A3_EX),
      .OpType_i     (OpType_EX),
      .RD1_V_i      (RD1_V_EX),
      .RD2_V_i      (RD2_V_EX),
      .AluResult_V_i(AluResult_V_EX),

      .RD1_S_o      (RD1_S_MEM),
      .RD2_S_o      (RD2_S_MEM),
      .AluResult_S_o(AluResult_S_MEM),
      .RegFile_WE_o (RegFile_WE_MEM),
      .MemWE_o      (MemWE_MEM),
      .WBSelect_o   (WBSelect_MEM),
      .OpSource_o   (OpSource_MEM),
      .A3_o         (A3_MEM),
      .OpType_o     (OpType_MEM),
      .RD1_V_o      (RD1_V_MEM),
      .RD2_V_o      (RD2_V_MEM),
      .AluResult_V_o(AluResult_V_MEM)
  );


  Pipe_MEM_WB #(
      .N(N),
      .V(V),
      .L(L)
  ) u_Pipe_MEM_WB (
      .CLK     (CLK),
      .RST     (RST),
      .enable_i(enable_i),

      .Data_Mem_S_i   (Data_Mem_S_MEM),
      .Data_Result_S_i(Data_Result_S_MEM),
      .RegFile_WE_i   (RegFile_WE_MEM),
      .WBSelect_i     (WBSelect_MEM),
      .A3_i           (A3_MEM),
      .OpType_i       (OpType_MEM),
      .Data_Mem_V_i   (Data_Mem_V_MEM),
      .Data_Result_V_i(Data_Result_V_MEM),

      .Data_Mem_S_o   (Data_Mem_S_WB),
      .Data_Result_S_o(Data_Result_S_WB),
      .RegFile_WE_o   (RegFile_WE_WB),
      .WBSelect_o     (WBSelect_WB),
      .A3_o           (A3_WB),
      .OpType_o       (OpType_WB),
      .Data_Mem_V_o   (Data_Mem_V_WB),
      .Data_Result_V_o(Data_Result_V_WB)
  );

  assign Data_Mem_S_MEM[N-1:8] = 0;


  MemStage #(
      .I(I),
      .L(L),
      .A(A)
  ) u_MemStage (
      .clk(CLK),
      .rst(RST_memStage),

      .op_type      (OpType_MEM[1]),
      .op_source    (OpSource_MEM),
      .write_enable (MemWE_MEM),
      .address      (RD1_S_MEM),
      .aluResultV   (AluResult_V_MEM),
      .rd2_vec      (RD2_V_MEM),
      .aluResultS   (AluResult_S_MEM[7:0]),
      .rd2_sca      (RD2_S_MEM[7:0]),
      .vector_output(Data_Mem_V_MEM),
      .scalar_output(Data_Mem_S_MEM[7:0]),
      .mem_data     (MEM_data_out),  //para guardar el resultado a un txt
      .mem_finished (MEM_ready)  // ready
  );

  always #5 CLK = ~CLK;

  //   RD1_S_EX=0;
  //   RD2_S_EX=0;
  //   AluResult_S_EX=0;
  //   RegFile_WE_EX=0;
  //   MemWE_EX=0;
  //   WBSelect_EX=0;
  //   OpSource_EX=0;
  //   A3_EX=0;
  //   OpType_EX=0;
  //   RD1_V_EX=0;
  //   RD2_V_EX=0;
  //   AluResult_V_EX=0;

  initial begin
    CLK = 0;
    RST = 1;
    #20 RST = 0;
    enable_i = 1;

    for (integer counter = 0; counter < 16; counter = counter + 1) begin
      wait(CLK == 0);
      #2;
      // enable_i = 1;
      RD1_S_EX = BASE_ADDRESS+counter;
      RD2_S_EX = counter;
      AluResult_S_EX = 0;
      RegFile_WE_EX = 0;
      MemWE_EX = 1;
      WBSelect_EX = 0;
      OpSource_EX = 0;
      A3_EX = 0;
      OpType_EX = 2'b00;
      RD1_V_EX = 0;
      RD2_V_EX = 0;
      AluResult_V_EX = 0;
      wait(CLK == 1);
      RST_memStage=1;
      #10;
      RST_memStage=0;


    end
    #2;
    for (integer counter = 0; counter < 16; counter = counter + 1) begin
      wait(CLK == 0);
      #2;
      RD1_S_EX = BASE_ADDRESS+counter;
      RD2_S_EX = 0;
      AluResult_S_EX = 0;
      RegFile_WE_EX = 0;
      MemWE_EX = 0;
      WBSelect_EX = 0;
      OpSource_EX = 0;
      A3_EX = 0;
      OpType_EX = 2'b00;
      RD1_V_EX = 0;
      RD2_V_EX = 0;
      AluResult_V_EX = 0;
      wait(CLK == 1);
      RST_memStage=1;
      #10;
      RST_memStage=0;
    end




    // for(integer i =0 ;i < V; i++)begin

    // end

  end


endmodule
