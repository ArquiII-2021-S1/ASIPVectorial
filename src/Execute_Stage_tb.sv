module Execute_Stage_tb ();
  parameter N = 32, V = 20;
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
//   logic [V-1:0][N-1:0] vector_o;

logic enable_ID_EX, enable_EX_MEM ;

logic [N-1:0] RD1_S_ID, RD2_S_ID, Extend_ID;
logic RegFile_WE_ID, ALUSource_ID, SetFlags_ID, MemWE_ID, WBSelect_ID, OpSource_ID;
logic [3:0] A3_ID;
logic [1:0] ALUControl_ID, BranchSelect_ID, OpType_ID;
logic [V-1:0][N-1:0] RD1_V_ID, RD2_V_ID;

logic [N-1:0] RD1_S_EX, RD2_S_EX, Extend_EX;
logic RegFile_WE_EX, ALUSource_EX, SetFlags_EX, MemWE_EX, WBSelect_EX, OpSource_EX;
logic [3:0] A3_EX;
logic [1:0] ALUControl_EX, BranchSelect_EX, OpType_EX;
logic [V-1:0][N-1:0] RD1_V_EX, RD2_V_EX;


 logic [N-1:0] AluResult_S_EX;
 logic [V-1:0][N-1:0] AluResult_V_EX;

 logic [N-1:0] RD1_S_MEM, RD2_S_MEM, AluResult_S_MEM;
 logic RegFile_WE_MEM, MemWE_MEM, WBSelect_MEM, OpSource_MEM;
 logic [3:0] A3_MEM;
 logic [1:0] OpType_MEM;
 logic [V-1:0][N-1:0] RD1_V_MEM, RD2_V_MEM, AluResult_V_MEM;



  Pipe_ID_EX #(
      .N(N),
      .V(V)
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
      .V(V)
  ) u_Pipe_EX_MEM (
      .CLK          (CLK),
      .RST          (RST),
      .enable_i     (enable_EX_MEM),

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



  ForkVector #(
      .N(N),
      .V(V)
  ) forckVector (
      .CLK(CLK),
      .RST(RST),
      .OpType(OpType_EX),
      .RD1_VEC_i(RD1_V_EX),
      .RD2_VEC_i(RD2_V_EX),
      .Scalar_i(RD1_S_EX),
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
      .vector_o(AluResult_V_EX)
  );



  ALU #(
      .N(N)
  ) alu0 (
      .A(Vec_A_o[0]),
      .B(Vec_B_o[0]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[0]),
      .ALUFlags()
  );

  ALU #(
      .N(N)
  ) alu1 (
      .A(Vec_A_o[1]),
      .B(Vec_B_o[1]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[1]),
      .ALUFlags()
  );

  ALU #(
      .N(N)
  ) alu2 (
      .A(Vec_A_o[2]),
      .B(Vec_B_o[2]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[2]),
      .ALUFlags()
  );

  ALU #(
      .N(N)
  ) alu3 (
      .A(Vec_A_o[3]),
      .B(Vec_B_o[3]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[3]),
      .ALUFlags()
  );
// OJO meter cables correctos
  ALU #(
      .N(N)
  ) aluScalar (
      .A(Vec_A_o[3]),
      .B(Vec_B_o[3]),
      .ALUControl(ALUControl),
      .ALUResult(vector_i[3]),
      .ALUFlags()
  );
  always #1 CLK = ~CLK;


  initial begin
    OpType     = 2'b01;  // vector-vector
    ALUControl = 2'b00;

    CLK        = 0;
    RST        = 1;
    Scalar_i   = 3;
    for (integer i = 0; i < V; i++) begin
      RD1_VEC_i[i] = i;
      RD2_VEC_i[i] = i * 2;
    end
    #1 RST = 0;
    #100 RST = 1;
    #1 RST = 0;
    OpType = 2'b10;  // vector-scalar
  end








endmodule
