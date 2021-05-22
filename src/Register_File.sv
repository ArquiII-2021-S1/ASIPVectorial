module Register_File #(N=32, I=20, L=8) (input  logic         		  clk, rst, WE,
													 input  logic [3:0]   		  A1, A2, A3_WB,
													 input  logic [N-1:0] 		  WD3_SCA,
													 input  logic [I-1:0][L-1:0] WD3_VEC,
													 output logic [N-1:0] 		  RD1_SCA, RD2_SCA,
													 output logic [I-1:0][L-1:0] RD1_VEC, RD2_VEC);
													
// Salidas de cada registro
logic[N-1:0] 		  r00_out, r01_out, r02_out, r03_out, r04_out, r05_out, r06_out, r07_out;
logic[I-1:0][L-1:0] r08_out, r09_out, r10_out, r11_out, r12_out, r13_out, r14_out, r15_out;

// Enable de cada registro
logic[15:0] reg_en;
Demux_1to16 DEMUX(WE, A3_WB, reg_en);

// Registros									  
Scalar_Register #(N)   REG00(clk,rst,reg_en[0],WD3_SCA,r00_out);
Scalar_Register #(N)   REG01(clk,rst,reg_en[1],WD3_SCA,r01_out);
Scalar_Register #(N)   REG02(clk,rst,reg_en[2],WD3_SCA,r02_out);
Scalar_Register #(N)   REG03(clk,rst,reg_en[3],WD3_SCA,r03_out);
Scalar_Register #(N)   REG04(clk,rst,reg_en[4],WD3_SCA,r04_out);
Scalar_Register #(N)   REG05(clk,rst,reg_en[5],WD3_SCA,r05_out);
Scalar_Register #(N)   REG06(clk,rst,reg_en[6],WD3_SCA,r06_out);
Scalar_Register #(N)   REG07(clk,rst,reg_en[7],WD3_SCA,r07_out);
Vector_Register #(I,L) REG08(clk,rst,reg_en[8], WD3_VEC,r08_out);
Vector_Register #(I,L) REG09(clk,rst,reg_en[9], WD3_VEC,r09_out);
Vector_Register #(I,L) REG10(clk,rst,reg_en[10],WD3_VEC,r10_out);
Vector_Register #(I,L) REG11(clk,rst,reg_en[11],WD3_VEC,r11_out);
Vector_Register #(I,L) REG12(clk,rst,reg_en[12],WD3_VEC,r12_out);
Vector_Register #(I,L) REG13(clk,rst,reg_en[13],WD3_VEC,r13_out);
Vector_Register #(I,L) REG14(clk,rst,reg_en[14],WD3_VEC,r14_out);
Vector_Register #(I,L) REG15(clk,rst,reg_en[15],WD3_VEC,r15_out);

// Selector de la salida correspondiente
Scalar_Mux_8 #(N) MUX_OUT_RD1_SCA(A1, r00_out, r01_out, r02_out, r03_out, r04_out,
											 r05_out, r06_out, r07_out, RD1_SCA);
Scalar_Mux_8 #(N) MUX_OUT_RD2_SCA(A2, r00_out, r01_out, r02_out, r03_out, r04_out,
											 r05_out, r06_out, r07_out, RD2_SCA);
Vector_Mux_8 #(I,L) MUX_OUT_RD1_VEC(A1, r08_out, r09_out, r10_out, r11_out, r12_out,
												r13_out, r14_out, r15_out, RD1_VEC);
Vector_Mux_8 #(I,L) MUX_OUT_RD2_VEC(A1, r08_out, r09_out, r10_out, r11_out, r12_out,
												r13_out, r14_out, r15_out, RD2_VEC);

endmodule 		