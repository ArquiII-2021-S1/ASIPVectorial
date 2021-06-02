module Stage_Decode_tb ();

  parameter N = 32, L = 8, I = 20, V = 20;



  logic CLK, RST, enable_i;

  // register file
  logic [ 3:0] OpCode_ID;
  logic [ 1:0] ExtendSelect;
  logic [12:0] imm_ID;
  logic [4:0] A1_ID, A2_ID;


  // control unit
  logic Finished_ID, Mem_Finished_MEM, Exe_Finished_EXE, ExtendSelect_ID;



  //pipes
  logic [N-1:0] instruction_IF, instruction_ID;

  logic [N-1:0] RD1_S_ID, RD2_S_ID, Extend_ID;
  logic RegFile_WE_ID, ALUSource_ID, SetFlags_ID, MemWE_ID, WBSelect_ID, OpSource_ID;
  logic [4:0] A3_ID;
  logic [1:0] ALUControl_ID, BranchSelect_ID, OpType_ID;
  logic [V-1:0][L-1:0] RD1_V_ID, RD2_V_ID;

  logic [N-1:0] RD1_S_EX, RD2_S_EX, Extend_EX;
  logic RegFile_WE_EX, ALUSource_EX, SetFlags_EX, MemWE_EX, WBSelect_EX, OpSource_EX;
  logic [4:0] A3_EX;
  logic [1:0] ALUControl_EX, BranchSelect_EX, OpType_EX;
  logic [V-1:0][L-1:0] RD1_V_EX, RD2_V_EX;


  // writeback
  logic RFWE_WB;
  logic [4:0] A3_WB;
  logic [N-1:0] WD3_SCA_WB;
  logic [I-1:0][L-1:0] WD3_VEC_WB;


  Pipe_IF_ID #(
      .N(N)
  ) u_Pipe_IF_ID (
      .CLK(CLK),
      .RST(RST),

      .instruction_i(instruction_IF),
      .instruction_o(instruction_ID)
  );

  Pipe_ID_EX #(
      .N(N),
      .V(V),
      .L(L)
  ) u_Pipe_ID_EX (
      .CLK     (CLK),
      .RST     (RST),
      .enable_i(enable_i),

      .RD1_S_i       (RD1_S_ID),
      .RD2_S_i       (RD2_S_ID),
      .Extend_i      (Extend_ID),
      .RegFile_WE_i  (RegFile_WE_ID),
      .ALUSource_i   (ALUSource_ID),
      .SetFlags_i    (SetFlags_ID),
      .MemWE_i       (MemWE_ID),
      .WBSelect_i    (WBSelect_ID),
      .OpSource_i    (OpSource_ID),
      .A3_i          (A3_ID),
      .ALUControl_i  (ALUControl_ID),
      .BranchSelect_i(BranchSelect_ID),
      .OpType_i      (OpType_ID),
      .RD1_V_i       (RD1_V_ID),
      .RD2_V_i       (RD2_V_ID),

      .RD1_S_o       (RD1_S_EX),
      .RD2_S_o       (RD2_S_EX),
      .Extend_o      (Extend_EX),
      .RegFile_WE_o  (RegFile_WE_EX),
      .ALUSource_o   (ALUSource_EX),
      .SetFlags_o    (SetFlags_EX),
      .MemWE_o       (MemWE_EX),
      .WBSelect_o    (WBSelect_EX),
      .OpSource_o    (OpSource_EX),
      .A3_o          (A3_EX),
      .ALUControl_o  (ALUControl_EX),
      .BranchSelect_o(BranchSelect_EX),
      .OpType_o      (OpType_EX),
      .RD1_V_o       (RD1_V_EX),
      .RD2_V_o       (RD2_V_EX)
  );



  //   definir las que vienen desde WB
  //   WE, A3, WD3V, WD3_S
  //assign instruction_id[15:0]





  assign OpCode_ID = instruction_ID[31:28];
  assign A1_ID = instruction_ID[22:18];
  assign A2_ID = instruction_ID[17:13];
  assign A3_ID = instruction_ID[27:23];
  assign imm_ID = instruction_ID[12:0];


  //   WD3_SCA_WB,WD3_VEC_WB



  Register_File #(
      .N(N),  //tamaño escalares
      .I(I),  //cantidad items
      .L(L)  // 8bits
  ) u_Register_File (
      .clk(CLK),
      .rst(RST),

      .WE     (RFWE_WB),
      .A1     (A1_ID),
      .A2     (A2_ID),
      .A3_WB  (A3_WB),
      .WD3_SCA(WD3_SCA_WB),
      .WD3_VEC(WD3_VEC_WB),
      .RD1_SCA(RD1_S_ID),
      .RD2_SCA(RD2_S_ID),
      .RD1_VEC(RD1_V_ID),
      .RD2_VEC(RD2_V_ID)
  );



  // por declarar 
  // ExtendSelect_ID,Finished_ID,Mem_Finished_MEM,Exe_Finished_EXE

  Control_Unit u_Control_Unit (
      .OpCode_i      (OpCode_ID),
      .Mem_Finished_i(Mem_Finished_MEM),
      .Exe_Finished_i(Exe_Finished_EXE),
      .RegFileWE_o   (RegFile_WE_ID),
      .ExtendSelect_o(ExtendSelect_ID),
      .ALUSource_o   (ALUSource_ID),
      .MemWE_o       (MemWE_ID),
      .OpSource_o    (OpSource_ID),
      .WBSelect_o    (WBSelect_ID),
      .Finished_o    (Finished_ID),
      .BranchSelect_o(BranchSelect_ID),
      .OpType_o      (OpType_ID),
      .ALUControl_o  (ALUControl_ID)
  );


  Extend u_Extend (
      .ExtendSelect(ExtendSelect_ID),
      .Imm_IN      (imm_ID),
      .ExtImm_OUT  (Extend_ID)
  );


  logic [31:0] counter;


  always #5 CLK = !CLK;

  initial begin
    CLK = 0;
    //llenar register file
    for (counter = 0; counter < 16; counter = counter + 1) begin
      wait(CLK == 1);
      #2;
      RFWE_WB = 1;
      A3_WB = counter[4:0];
      WD3_SCA_WB = counter;
      wait(CLK == 0);
    end
    RFWE_WB = 0;
    WD3_SCA_WB = 0;
    A3_WB = 0;




    //leer registerfile

    // instruction_IF[31:28]=0;	//OpCode
    // instruction_IF[27:24]=0;	//A1
    // instruction_IF[23:20]=0;	//A2
    // instruction_IF[19:16]=0;	//A3_id
    // instruction_IF[15:0]=0;	//imm


    // instruction_IF[12:0]=     0  ; //imm
    //  instruction_IF[17:13]=   0    ;//A2
    //  instruction_IF[22:18]=   0    ;//A1 cambia
    //  instruction_IF[27:23]=   0    ;//A3
    //  instruction_IF[31:28]=    4'b1010   ;//OpCode

    for (counter = 0; counter < 16; counter = counter + 1) begin
      wait(CLK == 0);
      #2;
      instruction_IF[12:0]  = 0;  //imm
      instruction_IF[17:13] = 0;  //A2
      instruction_IF[22:18] = counter[4:0];  //A1 cambia
      instruction_IF[27:23] = 0;  //A3
      instruction_IF[31:28] = 4'b1010;  //OpCode
      wait(CLK == 1);

      wait(CLK == 0);
      wait(CLK == 1);
      #1;
      assert (RD1_S_ID == counter)
      else $error("ERROR: RD1_id:%0d, counter:%0d", RD1_S_ID, counter);


    end
    $finish;
  end


endmodule
