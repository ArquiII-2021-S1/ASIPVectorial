module Execute_SuperModule #(
    N = 32,
    V = 20
) ();




  logic CLK;
  logic RST;
  logic [1:0] OpType;
  logic [V-1:0][N-1:0] RD1_VEC_i;
  logic [V-1:0][N-1:0] RD2_VEC_i;
  logic [N-1:0] Scalar_i;
  logic [4-1:0][N-1:0] Vec_A_o;
  logic [4-1:0][N-1:0] Vec_B_o;
  integer counter;

  logic [1:0] ALUControl, ALUFlags;


  logic [4-1:0][N-1:0] vector_i;
  logic [V-1:0][N-1:0] vector_o;










  

  ForkVector #(
      .N(N),
      .V(V)
  ) forckVector (
      .CLK(CLK),
      .RST(RST),
      .OpType(OpType),
      .RD1_VEC_i(RD1_VEC_i),
      .RD2_VEC_i(RD2_VEC_i),
      .Scalar_i(Scalar_i),
      .Vec_A_o(Vec_A_o),
      .Vec_B_o(Vec_B_o),
      .counter(counter)
  );

  JoinVector #(
      .N(N),
      .V(V)
  ) joinVector (
      .CLK(CLK),
      .RST(RST),
      .counter(counter),
      .vector_i(vector_i),
      .vector_o(vector_o)
  );

  ALU #(
      .N(N)
  ) ALU_V0 (
      .A(Vec_A_o[0]),
      .B(Vec_B_o[0]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[0]),
      .ALUFlags()
  );

  ALU #(
      .N(N)
  ) ALU_V1 (
      .A(Vec_A_o[0]),
      .B(Vec_B_o[0]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[0]),
      .ALUFlags()
  );

  ALU #(
      .N(N)
  ) ALU_V2 (
      .A(Vec_A_o[0]),
      .B(Vec_B_o[0]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[0]),
      .ALUFlags()
  );

  ALU #(
      .N(N)
  ) ALU_V3 (
      .A(Vec_A_o[0]),
      .B(Vec_B_o[0]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[0]),
      .ALUFlags()
  );

  ALU #(
      .N(N)
  ) ALU_S (
      .A         (A),
      .B         (B),
      .ALUControl(ALUControl),
      .ALUResult (ALUResult),
      .ALUFlags  (ALUFlags)
  );








endmodule
