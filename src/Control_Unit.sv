module Control_Unit(input 	logic[3:0] OpCode,
						  input  logic Mem_Finished, Exe_Finished,
						  output logic RegFileWE, ExtendSelect, ALUSource, MemWE, OpSource, WBSelect, Finished,				  
						  output logic[1:0] BranchSelect, OpType, ALUControl);
	
	// OpCode: codigo de operacion de la instruccion.
	// BranchSelect: selector de la operacion de branch.
	// RegFileWE: write enable del banco de registros.
	// ExtendSelect: selector de operacion de extension.
	// ALUSource: selector del mux de ALU escalar.
	// OpType: codigo de tipos de operandos.
	// ALUControl: codigo de operacion de la ALU.
	// MemWE: write enable de la memoria de datos.
	// OpSource: selector de los mux de etapa memoria.
	// WBSelect: selector de los mux del write back.
	
	logic [11:0] OUT;
	
	always_comb begin
		casex(OpCode)     //  109876543210
			4'b0000: OUT = 12'b0;           //NOP
								//	 BS R X A OT AC M O W
			4'b0001: OUT = 12'b010110001010;//Branch
			4'b0010: OUT = 12'b100110001010;//Branch equal
			4'b0011: OUT = 12'b001000100001;//Load Scalar
			4'b0100: OUT = 12'b001001100001;//Load Vector
			4'b0101: OUT = 12'b000000100100;//Store Scalar
			4'b0110: OUT = 12'b000001100100;//Store Vector
			4'b0111: OUT = 12'b001001100010;//Add Vector-Vector
			4'b1000: OUT = 12'b001001000010;//Add Vector-Scalar
			4'b1001: OUT = 12'b001110100010;//Add Scalar-Immediate
			4'b1010: OUT = 12'b001000100010;//Add Scalar-Scalar
			4'b1011: OUT = 12'b001000101010;//Substract Scalar-Scalar
			4'b1100: OUT = 12'b001001010010;//Shift Right Vector-Scalar
			4'b1101: OUT = 12'b001001011010;//Shift Left Vector-Scalar
			4'b1110: OUT = 12'b001000111010;//Shift Left Scalar-Scalar
			default: OUT = 12'b0;
		endcase
	end
	
	assign BranchSelect = OUT[11:10];
	assign RegFileWE = OUT[9];
	assign ExtendSelect = OUT[8];
	assign ALUSource = OUT[7];
	assign OpType = OUT[6:5];
	assign ALUControl = OUT[4:3];
	assign MemWE = OUT[2];
	assign OpSource = OUT[1];
	assign WBSelect = OUT[0];
	assign Finished = Mem_Finished & Exe_Finished;
			

endmodule						  
