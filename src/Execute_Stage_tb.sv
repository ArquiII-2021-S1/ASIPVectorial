module Execute_Stage_tb ();
    parameter N = 32, V = 20;
    logic CLK;
    logic RST;
    logic[1:0] OpType;
    logic [V-1:0][N-1:0] RD1_VEC_i;
    logic [V-1:0][N-1:0] RD2_VEC_i;
    logic [N-1:0] Scalar_i;
    logic [4-1:0][N-1:0] Vec_A_o;
    logic [4-1:0][N-1:0] Vec_B_o;
    integer counter;
    
    logic [1:0] ALUControl, ALUFlags;
    
    
    logic 	[4-1:0][N-1:0] vector_i;
    logic 	[V-1:0][N-1:0] vector_o;
    
    ForkVector #(.N(N), .V(V)) forckVector(
    .CLK(CLK),
    .RST(RST),
    .OpType(OpType),
    .RD1_VEC_i(RD1_VEC_i),
    .RD2_VEC_i(RD2_VEC_i),
    .Scalar_i(Scalar_i),
    .Vec_A_o(Vec_A_o),
    .Vec_B_o(Vec_B_o),
    .counter(counter));
    
    JoinVector #(.N(N) , .V(V)) joinVector(
    .CLK(CLK),
    .RST(RST),
    .counter(counter),
    .vector_i(vector_i),
    .vector_o(vector_o)
    );
    
    
    
    ALU #(.N(N)) alu0(
    .A(Vec_A_o[0]),
    .B(Vec_B_o[0]),
    .ALUControl(ALUControl),
    .ALUResult(vector_i[0]),
    .ALUFlags());
    
    ALU #(.N(N)) alu1(
    .A(Vec_A_o[1]),
    .B(Vec_B_o[1]),
    .ALUControl(ALUControl),
    .ALUResult(vector_i[1]),
    .ALUFlags());
    
    ALU #(.N(N)) alu2(
    .A(Vec_A_o[2]),
    .B(Vec_B_o[2]),
    .ALUControl(ALUControl),
    .ALUResult(vector_i[2]),
    .ALUFlags());
    
    ALU #(.N(N)) alu3(
    .A(Vec_A_o[3]),
    .B(Vec_B_o[3]),
    .ALUControl(ALUControl),
    .ALUResult(vector_i[3]),
    .ALUFlags());
    
    
    always #1 CLK = ~CLK;
    
    
    initial begin
        OpType     = 2'b01; // vector-vector
        ALUControl = 2'b00;
        
        CLK      = 0;
        RST      = 1;
        Scalar_i = 3;
        for(integer i = 0 ;i < V; i++)begin
            RD1_VEC_i[i] = i;
            RD2_VEC_i[i] = i*2;
        end
        #1 RST   = 0;
        #100 RST = 1;
        #1 RST   = 0;
        OpType   = 2'b10;// vector-scalar
    end
    
    
    
    
    
    
    
    
endmodule
