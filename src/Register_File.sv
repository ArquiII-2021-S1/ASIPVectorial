module Register_File #(N=32, I=20, L=8) (input  logic         		  clk, rst, WE,
													 input  logic [4:0]   		  A1, A2, A3_WB,
													 input  logic [N-1:0] 		  WD3_SCA,
													 input  logic [I-1:0][L-1:0] WD3_VEC,
													 output logic [N-1:0] 		  RD1_SCA, RD2_SCA,
													 output logic [I-1:0][L-1:0] RD1_VEC, RD2_VEC);
													
// Salidas de cada registro
logic[N-1:0] 		  r00_out, r01_out, r02_out, r03_out, r04_out, r05_out, r06_out, r07_out,
						  r08_out, r09_out, r10_out, r11_out, r12_out, r13_out, r14_out, r15_out;
logic[I-1:0][L-1:0] r16_out, r17_out, r18_out, r19_out, r20_out, r21_out, r22_out, r23_out;

// Enable de cada registro
logic[23:0] reg_en;
Demux_1to24 DEMUX(WE, A3_WB, reg_en);

// Registros									  
Scalar_Register #(N)   REG00(clk,rst,reg_en[0],WD3_SCA,r00_out);
Scalar_Register #(N)   REG01(clk,rst,reg_en[1],WD3_SCA,r01_out);
Scalar_Register #(N)   REG02(clk,rst,reg_en[2],WD3_SCA,r02_out);
Scalar_Register #(N)   REG03(clk,rst,reg_en[3],WD3_SCA,r03_out);
Scalar_Register #(N)   REG04(clk,rst,reg_en[4],WD3_SCA,r04_out);
Scalar_Register #(N)   REG05(clk,rst,reg_en[5],WD3_SCA,r05_out);
Scalar_Register #(N)   REG06(clk,rst,reg_en[6],WD3_SCA,r06_out);
Scalar_Register #(N)   REG07(clk,rst,reg_en[7],WD3_SCA,r07_out);
Scalar_Register #(N)   REG08(clk,rst,reg_en[8],WD3_SCA,r08_out);
Scalar_Register #(N)   REG09(clk,rst,reg_en[9],WD3_SCA,r09_out);
Scalar_Register #(N)   REG10(clk,rst,reg_en[10],WD3_SCA,r10_out);
Scalar_Register #(N)   REG11(clk,rst,reg_en[11],WD3_SCA,r11_out);
Scalar_Register #(N)   REG12(clk,rst,reg_en[12],WD3_SCA,r12_out);
Scalar_Register #(N)   REG13(clk,rst,reg_en[13],WD3_SCA,r13_out);
Scalar_Register #(N)   REG14(clk,rst,reg_en[14],WD3_SCA,r14_out);
Scalar_Register #(N)   REG15(clk,rst,reg_en[15],WD3_SCA,r15_out);
Vector_Register #(I,L) REG16(clk,rst,reg_en[16],WD3_VEC,r16_out);
Vector_Register #(I,L) REG17(clk,rst,reg_en[17],WD3_VEC,r17_out);
Vector_Register #(I,L) REG18(clk,rst,reg_en[18],WD3_VEC,r18_out);
Vector_Register #(I,L) REG19(clk,rst,reg_en[19],WD3_VEC,r19_out);
Vector_Register #(I,L) REG20(clk,rst,reg_en[20],WD3_VEC,r20_out);
Vector_Register #(I,L) REG21(clk,rst,reg_en[21],WD3_VEC,r21_out);
Vector_Register #(I,L) REG22(clk,rst,reg_en[22],WD3_VEC,r22_out);
Vector_Register #(I,L) REG23(clk,rst,reg_en[23],WD3_VEC,r23_out);

// Selector de la salida correspondiente
Scalar_Mux_16 #(N) MUX_OUT_RD1_SCA1(A1, r00_out, r01_out, r02_out, r03_out, r04_out,
													r05_out, r06_out, r07_out, r08_out, r09_out, 
													r10_out, r11_out, r12_out, r13_out, r14_out,
													r15_out, RD1_SCA);
Scalar_Mux_16 #(N) MUX_OUT_RD2_SCA2(A2, r00_out, r01_out, r02_out, r03_out, r04_out,
													r05_out, r06_out, r07_out, r08_out, r09_out, 
													r10_out, r11_out, r12_out, r13_out, r14_out,
													r15_out, RD2_SCA);
Vector_Mux_8 #(I,L) MUX_OUT_RD1_VEC1(A1, r16_out, r17_out, r18_out, r19_out, r20_out,
												    r21_out, r22_out, r23_out, RD1_VEC);
Vector_Mux_8 #(I,L) MUX_OUT_RD2_VEC2(A2, r16_out, r17_out, r18_out, r19_out, r20_out,
												    r21_out, r22_out, r23_out, RD2_VEC);

endmodule 		