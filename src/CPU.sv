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

  parameter N = 32, L = 1, V = 1, A = 1;
  logic RST_pipe_if_id, RST_pipe_id_ex, RST_pipe_ex_mem, RST_pipe_mem_wb;



  //FETCH
  logic RST_pc;
  logic WE_pc = 1;
  logic [31:0] instruction_if;
  logic [31:0] pc_i, pc_o;
  logic [31:0] PC_1, PC_label;
  logic pc_select;
  logic [31:0] RD1_if;
  logic [31:0] RD2_if;

  //DECODE


  //EXECUTE


  //MEM


  //WriteBack



  //#############################    FETCH   ####################################

  assign PC_1 = pc_o + 1;
  assign PC_label = pc_o + Extend_ex;
  //mux pc
  assign pc_i = (pc_select) ? (PC_label) : (PC_1);

  PC_controller pc_controller (
      .branchselect_id_i(BranchSelect_id),
      .branchselect_ex_i(BranchSelect_ex),
      .ALU_flags_i(ALU_flags_ex),
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

  assign instruction_if = inst_mem_data_i;
  assign inst_mem_address_o = pc_o;
  assign RST_pc = RST;



  //#############################   DECODE   ####################################


  //#############################  EXECUTE   ####################################


  //#############################    MEM     ####################################


  //############################# WriteBack  ####################################


endmodule  //CPU
