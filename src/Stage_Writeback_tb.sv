module Writeback_tb();

	parameter N = 32, L = 8, V = 20, I = 20;	

	logic CLK;
	logic RST;
   logic enable_i;

   logic RegFile_WE_MEM, WBSelect_MEM;
   logic [4:0] A3_MEM;
   logic [1:0] OpType_MEM;
   logic [N-1:0] Data_Mem_S_MEM, Data_Result_S_MEM;
   logic [V-1:0][L-1:0] Data_Mem_V_MEM, Data_Result_V_MEM;

   logic [N-1:0] Data_Mem_S_WB, Data_Result_S_WB;
   logic RegFile_WE_WB, WBSelect_WB;
   logic [4:0] A3_WB;
   logic [1:0] OpType_WB;
   logic [V-1:0][L-1:0] Data_Mem_V_WB, Data_Result_V_WB;
	
	
	logic [N-1:0] WD3_SCA;
	logic [V-1:0][L-1:0] WD3_VEC;

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


	assign WD3_SCA = WBSelect_WB ? Data_Result_S_WB:Data_Mem_S_WB;
	assign WD3_VEC = WBSelect_WB ? Data_Result_V_WB:Data_Mem_V_WB;


	initial begin
		CLK = 0;
		RST = 0;
		enable_i = 1;
		
		RegFile_WE_MEM = 0;
		WBSelect_MEM = 0;
		A3_MEM = 5'b00001;
		OpType_MEM = 0;
		
		Data_Mem_S_MEM = 1;
		Data_Result_S_MEM = 2;
		
		for(integer i =0 ;i < V; i++)begin
        Data_Mem_V_MEM[i]=i;
        Data_Result_V_MEM[i]=i*2;
		end
		#10;
		
		WBSelect_MEM = 1;
		#10;
		
	end
	
	always #5 CLK = ~CLK;

endmodule