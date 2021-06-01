module ForkVector_tb();
    parameter N = 32, V = 20;
    logic CLK;
    logic RST;
	 logic ready_o;
    logic[1:0] OpType;
    logic [V-1:0][N-1:0] RD1_VEC_i;
    logic [V-1:0][N-1:0] RD2_VEC_i;
    logic [N-1:0] Scalar_i;
    logic [4-1:0][N-1:0] Vec_A_o;
    logic [4-1:0][N-1:0] Vec_B_o;
    integer counter;
    ForkVector #(.N(N), .V(V)) DUT(.*);
    
    
    
    always #1 CLK = ~CLK;
    
    
    initial begin
        OpType   = 2'b01; // vector-vector
        CLK      = 0;
        RST      = 1;
        Scalar_i = 3;
        for(integer i = 0 ;i < V; i++)begin
            RD1_VEC_i[i] = i;
            RD2_VEC_i[i] = i*2;
        end
        #1 RST  = 0;
        #10 RST = 1;
        #1 RST  = 0;
        OpType  = 2'b10;// vector-scalar
    end
    
    
endmodule
