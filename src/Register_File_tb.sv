module Register_File_tb();

logic clk, rst, WE;
logic [3:0] A1, A2, A3_WB;
logic [3:0] WD3_SCA, RD1_SCA, RD2_SCA;
logic [1:0][3:0] WD3_VEC, RD1_VEC, RD2_VEC;

Register_File DUT(clk, rst, WE, A1, A2, A3_WB, WD3_SCA, WD3_VEC, RD1_SCA, RD2_SCA, RD1_VEC, RD2_VEC);

initial begin
	clk = 1;
	rst = 0;
	A1 = 0;
	A2 = 0;
	A3_WB = 0;
	WE = 0;
	WD3_SCA = 0;
	WD3_VEC = 0;
	#10;
	
	//Caso 1: Escribir WD3_SCA en Registro R1 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 4'b0001;
	A2 = 4'b0001;
	A3_WB = 4'b0001;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 1 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 1 RD2 failed.");

	//Caso 2: Escribir WD3_SCA en Registro R2 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 4'b0010;
	A2 = 4'b0010;
	A3_WB = 4'b0010;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 2 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 2 RD2 failed.");
	
	//Caso 3: Escribir WD3_SCA en Registro R3 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 4'b0011;
	A2 = 4'b0011;
	A3_WB = 4'b0011;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 3 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 3 RD2 failed.");
	
	//Caso 4: Escribir WD3_SCA en Registro R4 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 4'b0100;
	A2 = 4'b0100;
	A3_WB = 4'b0100;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 4 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 4 RD2 failed.");
	
	//Caso 5: Escribir WD3_SCA en Registro R5 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 4'b0101;
	A2 = 4'b0101;
	A3_WB = 4'b0101;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 5 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 5 RD2 failed.");
	
	//Caso 6: Escribir WD3_SCA en Registro R6 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 4'b0110;
	A2 = 4'b0110;
	A3_WB = 4'b0110;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 6 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 6 RD2 failed.");
	
	//Caso 7: Escribir WD3_SCA en Registro R7 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 4'b0111;
	A2 = 4'b0111;
	A3_WB = 4'b0111;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 7 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 7 RD2 failed.");
	
	
	//Caso 8: Escribir WD3_VEC en Registro R8 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = { 4'b1100, 4'b1010};
	A1 = 4'b1000;
	A2 = 4'b1000;
	A3_WB = 4'b1000;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 8 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 8 RD2 failed.");
	
	//Caso 9: Escribir WD3_VEC en Registro R9 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = { 4'b1100, 4'b1010};
	A1 = 4'b1001;
	A2 = 4'b1001;
	A3_WB = 4'b1001;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 9 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 9 RD2 failed.");
	
	//Caso 10: Escribir WD3_VEC en Registro R10 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = { 4'b1100, 4'b1010};
	A1 = 4'b1010;
	A2 = 4'b1010;
	A3_WB = 4'b1010;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 10 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 10 RD2 failed.");
	
	//Caso 11: Escribir WD3_VEC en Registro R11 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = { 4'b1100, 4'b1010};
	A1 = 4'b1011;
	A2 = 4'b1011;
	A3_WB = 4'b1011;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 11 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 11 RD2 failed.");
	
	//Caso 12: Escribir WD3_VEC en Registro R12 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = { 4'b1100, 4'b1010};
	A1 = 4'b1100;
	A2 = 4'b1100;
	A3_WB = 4'b1100;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 12 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 12 RD2 failed.");
	
	//Caso 13: Escribir WD3_VEC en Registro R13 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = { 4'b1100, 4'b1010};
	A1 = 4'b1101;
	A2 = 4'b1101;
	A3_WB = 4'b1101;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 13 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 13 RD2 failed.");
	
	//Caso 14: Escribir WD3_VEC en Registro R14 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = { 4'b1100, 4'b1010};
	A1 = 4'b1110;
	A2 = 4'b1110;
	A3_WB = 4'b1110;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 14 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 14 RD2 failed.");
	
	// Caso 15: Escribir WD3_VEC en Registro R15 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = { 4'b1100, 4'b1010};
	A1 = 4'b1111;
	A2 = 4'b1111;
	A3_WB = 4'b1111;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 15 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 15 RD2 failed.");
	
end

always
	#5 clk = !clk;

endmodule 