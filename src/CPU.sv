module CPU (
    CLK,
    RST,
    inst_mem_data_i,
    inst_mem_address_o,
    data_mem_out_data_i,
    data_mem_address_o,
    data_mem_in_data_o,
    data_mem_WE_o
);
  input logic CLK, RST;
  input logic [31:0] inst_mem_data_i, data_mem_out_data_i;
  output logic [31:0] data_mem_in_data_o, data_mem_address_o, inst_mem_address_o;
  output logic data_mem_WE_o;

  parameter N = 32, L = 8, V = 20, A = 32, I = 20;

  logic enable = 1;


  logic clear_pipes_o;


  logic RST_pipe_if_id, RST_pipe_id_ex, RST_pipe_ex_mem, RST_pipe_mem_wb;

  //assign RST_pipe_if_id = RST;
  assign RST_pipe_if_id  = RST || clear_pipes_o;
  assign RST_pipe_id_ex  = RST || clear_pipes_o;
  assign RST_pipe_ex_mem = RST;
  assign RST_pipe_mem_wb = RST;

  //FETCH
  logic RST_pc;
  logic WE_pc = 1;
  //   logic [31:0] instruction_if;
  logic [31:0] pc_i, pc_o;
  logic [31:0] PC_1, PC_label;
  logic pc_select;
  logic [31:0] RD1_if;
  logic [31:0] RD2_if;

  logic reset_int_mem;
  logic CLK_ng;
  assign CLK_ng = !CLK;

  //DECODE
  // register file
  logic [ 3:0] OpCode_ID;
  logic [ 1:0] ExtendSelect;
  logic [12:0] imm_ID;
  logic [4:0] A1_ID, A2_ID;
  // control unit
  logic Finished_ID, Mem_Finished_MEM, Exe_Finished_EXE, ExtendSelect_ID;


  //EXECUTE
  logic [1:0] ALU_flags_EX;
  logic [N-1:0] Scalar_i_EX;
  logic [4-1:0][L-1:0] Vec_A_o_EX;
  logic [4-1:0][L-1:0] Vec_B_o_EX;
  integer counter_EX;

  logic [4-1:0][L-1:0] vector_i_EX;
  logic [V-1:0][L-1:0] vector_o_EX;
  logic [N-1:0] alumux_result;
  logic fork_ready, ready_o_EX;
  logic [1:0] ALUFlags_EX;

  //MEM

  logic temp_mem_finish;
  logic MEM_ready;
  logic [L-1:0] MEM_data_out;
  logic RST_memStage;


  //WriteBack
  logic RFWE_WB;
  logic [N-1:0] WD3_SCA_WB;
  logic [I-1:0][L-1:0] WD3_VEC_WB;




  //   PIPES

  logic enable_ID_EX, enable_EX_MEM, enable_MEM_WB;


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


  logic [N-1:0] AluResult_S_EX;
  logic [V-1:0][L-1:0] AluResult_V_EX;

  logic [N-1:0] RD1_S_MEM, RD2_S_MEM, AluResult_S_MEM;
  logic RegFile_WE_MEM, MemWE_MEM, WBSelect_MEM, OpSource_MEM;
  logic [4:0] A3_MEM;
  logic [1:0] OpType_MEM;
  logic [V-1:0][L-1:0] RD1_V_MEM, RD2_V_MEM, AluResult_V_MEM;
  logic [N-1:0] Data_Mem_S_MEM, Data_Result_S_MEM;
  logic [V-1:0][L-1:0] Data_Mem_V_MEM, Data_Result_V_MEM;


  logic [N-1:0] Data_Mem_S_WB, Data_Result_S_WB;
  logic RegFile_WE_WB, WBSelect_WB;
  logic [4:0] A3_WB;
  logic [1:0] OpType_WB;
  logic [V-1:0][L-1:0] Data_Mem_V_WB, Data_Result_V_WB;





  Pipe_IF_ID #(
      .N(N)
  ) u_Pipe_IF_ID (
      .CLK(CLK),
      .RST(RST),

      .instruction_i(instruction_IF),
      .instruction_o(instruction_ID)
  );
  assign enable_ID_EX = enable;
  Pipe_ID_EX #(
      .N(N),
      .V(V),
      .L(L)
  ) u_Pipe_ID_EX (
      .CLK     (CLK),
      .RST     (RST),
      .enable_i(enable_ID_EX),

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


  Pipe_EX_MEM #(
      .N(N),
      .V(V),
      .L(L)
  ) u_Pipe_EX_MEM (
      .CLK     (CLK),
      .RST     (RST),
      .enable_i(Finished_ID),

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
      .enable_i(Finished_ID),  //conectar enable

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

  //#############################    FETCH   ####################################

  assign PC_1 = pc_o + 1;
  assign PC_label = pc_o + Extend_EX;
  //mux pc
  assign pc_i = (pc_select) ? (PC_label) : (PC_1);

  PC_controller pc_controller (  //OJO CON LAS SEÑALES
      .branchselect_id_i(BranchSelect_ID),
      .branchselect_ex_i(BranchSelect_EX),
      .ALU_flags_i(ALU_flags_EX),
      .pc_select_o(pc_select),
      .clear_pipes_o(clear_pipes_o)
  );

  Register #(
      .N(N)
  ) PC (
      .CLK(CLK),
      .RST(RST_pc),
      .EN(WE_pc),
      .Data_In(pc_i),
      .Data_Out(pc_o)
  );

  Inst_ROM instruction_ROM (
      .address(pc_o[11:0]),
      .clock(CLK_ng),
      .q(instruction_IF)
  );




  //#############################   DECODE   ####################################
  assign OpCode_ID = instruction_ID[31:28];
  assign A1_ID = instruction_ID[22:18];
  assign A2_ID = instruction_ID[17:13];
  assign A3_ID = instruction_ID[27:23];
  assign imm_ID = instruction_ID[12:0];



  Register_File #(
      .N(N),  //tamaño escalares
      .I(I),  //cantidad items
      .L(L)  // 8bits
  ) u_Register_File (
      .clk(CLK),
      .rst(RST),

      .WE     (RegFile_WE_WB),
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

  Control_Unit u_Control_Unit (
      .OpCode_i      (OpCode_ID),
      .Mem_Finished_i(temp_mem_finish),
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


  //#############################  EXECUTE   ####################################

  ForkVector #(
      .N(N),
      .L(L),
      .V(V)
  ) forkVector (
      .CLK(CLK),
      .RST(RST),
      .OpType(OpType_EX),
      .RD1_VEC_i(RD1_V_EX),
      .RD2_VEC_i(RD2_V_EX),
      .Scalar_i(Scalar_i_EX),
      .Vec_A_o(Vec_A_o_EX),
      .Vec_B_o(Vec_B_o_EX),
      .counter(counter_EX),
      .ready_o(fork_ready)
  );

  ALU #(
      .N(L)
  ) alu0 (
      .A(Vec_A_o_EX[0]),
      .B(Vec_B_o_EX[0]),
      .ALUControl(ALUControl_EX),
      .ALUResult(vector_i_EX[0]),
      .ALUFlags()
  );

  ALU #(
      .N(L)
  ) alu1 (
      .A(Vec_A_o_EX[1]),
      .B(Vec_B_o_EX[1]),
      .ALUControl(ALUControl_EX),
      .ALUResult(vector_i_EX[1]),
      .ALUFlags()
  );

  ALU #(
      .N(L)
  ) alu2 (
      .A(Vec_A_o_EX[2]),
      .B(Vec_B_o_EX[2]),
      .ALUControl(ALUControl_EX),
      .ALUResult(vector_i_EX[2]),
      .ALUFlags()
  );

  ALU #(
      .N(L)
  ) alu3 (
      .A(Vec_A_o_EX[3]),
      .B(Vec_B_o_EX[3]),
      .ALUControl(ALUControl_EX),
      .ALUResult(vector_i_EX[3]),
      .ALUFlags()
  );
  assign alumux_result = (ALUSource_EX) ? Extend_EX : RD2_S_EX;

  ALU #(
      .N(N)
  ) aluScalar (
      .A(RD1_S_EX),
      .B(alumux_result),
      .ALUControl(ALUControl_EX),
      .ALUResult(AluResult_S_EX),
      .ALUFlags(ALUFlags_EX)
  );

  Execute_Stage_ready #(
      .N(N)
  ) u_Execute_Stage_ready (
      .OpType_i(OpType_EX),
      .fork_ready_i(fork_ready),
      .ready_o(ready_o_EX)
  );

  assign Exe_Finished_EXE = ready_o_EX;



  //   assign RST_memStage = MEM_ready

  //#############################    MEM     ####################################
  assign Data_Mem_S_MEM[N-1:8] = 0;

  MemStage #(
      .I(I),
      .L(L),
      .A(A)
  ) u_MemStage (
      .clk(CLK),
      .rst(Finished_ID),

      .op_type      (OpType_MEM),
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
      .mem_finished (Mem_Finished_MEM)  // ready
  );
assign temp_mem_finish = Mem_Finished_MEM||(~WBSelect_MEM);

  //############################# WriteBack  ####################################
  assign WD3_SCA_WB = WBSelect_WB ? Data_Mem_S_WB : Data_Result_S_WB;
  assign WD3_VEC_WB = WBSelect_WB ? Data_Mem_V_WB : Data_Result_V_WB;

endmodule  //CPU
