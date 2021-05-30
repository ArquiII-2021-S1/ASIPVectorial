module Register_File_tb();

logic clk, rst, WE;
logic [4:0] A1, A2, A3_WB;
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
	A1 = 5'b00001;
	A2 = 5'b00001;
	A3_WB = 5'b00001;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 1 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 1 RD2 failed.");

	//Caso 2: Escribir WD3_SCA en Registro R2 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b00010;
	A2 = 5'b00010;
	A3_WB = 5'b00010;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 2 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 2 RD2 failed.");
	
	//Caso 3: Escribir WD3_SCA en Registro R3 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b00011;
	A2 = 5'b00011;
	A3_WB = 5'b00011;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 3 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 3 RD2 failed.");
	
	//Caso 4: Escribir WD3_SCA en Registro R4 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b00100;
	A2 = 5'b00100;
	A3_WB = 5'b00100;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 4 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 4 RD2 failed.");
	
	//Caso 5: Escribir WD3_SCA en Registro R5 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b00101;
	A2 = 5'b00101;
	A3_WB = 5'b00101;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 5 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 5 RD2 failed.");
	
	//Caso 6: Escribir WD3_SCA en Registro R6 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b00110;
	A2 = 5'b00110;
	A3_WB = 5'b00110;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 6 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 6 RD2 failed.");
	
	//Caso 7: Escribir WD3_SCA en Registro R7 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b00111;
	A2 = 5'b00111;
	A3_WB = 5'b00111;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 7 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 7 RD2 failed.");
	
	//Caso 8: Escribir WD3_SCA en Registro R8 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b01000;
	A2 = 5'b01000;
	A3_WB = 5'b01000;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 8 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 8 RD2 failed.");
	
	//Caso 9: Escribir WD3_SCA en Registro R9 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b01001;
	A2 = 5'b01001;
	A3_WB = 5'b01001;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 9 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 9 RD2 failed.");
	
	//Caso 10: Escribir WD3_SCA en Registro R10 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b01010;
	A2 = 5'b01010;
	A3_WB = 5'b01010;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 10 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 10 RD2 failed.");
	
	//Caso 11: Escribir WD3_SCA en Registro R11 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b01011;
	A2 = 5'b01011;
	A3_WB = 5'b01011;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 11 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 11 RD2 failed.");
	
	//Caso 12: Escribir WD3_SCA en Registro R12 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b01100;
	A2 = 5'b01100;
	A3_WB = 5'b01100;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 12 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 12 RD2 failed.");
	
	//Caso 13: Escribir WD3_SCA en Registro R13 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b01101;
	A2 = 5'b01101;
	A3_WB = 5'b01101;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 13 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 13 RD2 failed.");
	
	//Caso 14: Escribir WD3_SCA en Registro R14 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b01110;
	A2 = 5'b01110;
	A3_WB = 5'b01110;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 14 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 14 RD2 failed.");
	
	//Caso 15: Escribir WD3_SCA en Registro R15 y leerlo en las salidas RD1 y RD2 escalares
	WE = 1;
	WD3_SCA = 4'b1111;
	A1 = 5'b01111;
	A2 = 5'b01111;
	A3_WB = 5'b01111;
	#10
	assert (RD1_SCA === WD3_SCA) else $error("Case 15 RD1 failed.");
	assert (RD2_SCA === WD3_SCA) else $error("Case 15 RD2 failed.");
	
	
	//Caso 16: Escribir WD3_VEC en Registro R16 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = {4'b1100, 4'b1010};
	A1 = 5'b10000;
	A2 = 5'b10000;
	A3_WB = 5'b10000;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 16 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 16 RD2 failed.");
	
	//Caso 17: Escribir WD3_VEC en Registro R17 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = {4'b1100, 4'b1010};
	A1 = 5'b10001;
	A2 = 5'b10001;
	A3_WB = 5'b10001;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 17 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 17 RD2 failed.");
	
	//Caso 18: Escribir WD3_VEC en Registro R18 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = {4'b1100, 4'b1010};
	A1 = 5'b10010;
	A2 = 5'b10010;
	A3_WB = 5'b10010;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 18 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 18 RD2 failed.");
	
	//Caso 19: Escribir WD3_VEC en Registro R19 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = {4'b1100, 4'b1010};
	A1 = 5'b10011;
	A2 = 5'b10011;
	A3_WB = 5'b10011;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 19 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 19 RD2 failed.");
	
	//Caso 20: Escribir WD3_VEC en Registro R20 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = {4'b1100, 4'b1010};
	A1 = 5'b10100;
	A2 = 5'b10100;
	A3_WB = 5'b10100;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 20 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 20 RD2 failed.");
	
	//Caso 21: Escribir WD3_VEC en Registro R21 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = {4'b1100, 4'b1010};
	A1 = 5'b10101;
	A2 = 5'b10101;
	A3_WB = 5'b10101;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 21 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 21 RD2 failed.");
	
	//Caso 22: Escribir WD3_VEC en Registro R22 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = {4'b1100, 4'b1010};
	A1 = 5'b10110;
	A2 = 5'b10110;
	A3_WB = 5'b10110;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 22 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 22 RD2 failed.");
	
	// Caso 23: Escribir WD3_VEC en Registro R23 y leerlo en las salidas RD1 y RD2 vectoriales
	WE = 1;
	WD3_VEC = {4'b1100, 4'b1010};
	A1 = 5'b10111;
	A2 = 5'b10111;
	A3_WB = 5'b10111;
	#10
	assert (RD1_VEC === WD3_VEC) else $error("Case 23 RD1 failed.");
	assert (RD2_VEC === WD3_VEC) else $error("Case 23 RD2 failed.");
	
end

always
	#5 clk = !clk;

endmodule 