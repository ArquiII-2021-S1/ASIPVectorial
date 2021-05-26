module Control_Unit(input 	logic[3:0] OpCode,
						  input  logic Mem_Finished, Exe_Finished,
						  output logic RegFileWE, ExtendSelect, ALUSource, MemWE, WBSelect, Finished,				  
						  output logic[1:0] BranchSelect, OpType, ALUControl);
	
	// OpCode: codigo de operacion de la instruccion.
	// BranchSelect: selector de la operacion de branch.
	// RegFileWE: write enable del banco de registros.
	// ExtendSelect: selector de operacion de extension.
	// ALUSource: selector del mux de ALU escalar.
	// OpType: codigo de tipos de operandos.
	// ALUControl: codigo de operacion de la ALU.
	// MemWE: write enable de la memoria de datos.
	// WBSelect: selector de los mux del write back.
	
	logic [10:0] OUT;
	
	always_comb begin
		casex(OpCode)     //  109876543210
			4'b0000: OUT = 11'b0;           //NOP
								//	 BS R X A OT AC M W
			4'b0001: OUT = 11'b01011000100;//Branch
			4'b0010: OUT = 11'b10011000100;//Branch equal
			4'b0011: OUT = 11'b00100000001;//Load Scalar
			4'b0100: OUT = 11'b00100000001;//Load Vector
			4'b0101: OUT = 11'b00000000010;//Store Scalar
			4'b0110: OUT = 11'b00000000010;//Store Vector
			4'b0111: OUT = 11'b00100010000;//Add Vector-Vector
			4'b1000: OUT = 11'b00100100000;//Add Vector-Scalar
			4'b1001: OUT = 11'b00101110000;//Add Scalar-Scalar
			4'b1010: OUT = 11'b00101110100;//Substract Scalar-Scalar
			4'b1011: OUT = 11'b00100101000;//Shift Right Vector-Scalar
			4'b1100: OUT = 11'b00100101100;//Shift Left Vector-Scalar
			default: OUT = 11'b0;
		endcase
	end
	
	assign BranchSelect = OUT[10:9];
	assign RegFileWE = OUT[8];
	assign ExtendSelect = OUT[7];
	assign ALUSource = OUT[6];
	assign OpType = OUT[5:4];
	assign ALUControl = OUT[3:2];
	assign MemWE = OUT[1];
	assign WBSelect = OUT[0];
	assign Finished = Mem_Finished & Exe_Finished;
			

endmodule						  
