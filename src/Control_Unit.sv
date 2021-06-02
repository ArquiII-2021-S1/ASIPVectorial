module Control_Unit (OpCode_i,
                     Mem_Finished_i,
                     Exe_Finished_i,
                     RegFileWE_o,
                     ExtendSelect_o,
                     ALUSource_o,
                     MemWE_o,
                     OpSource_o,
                     WBSelect_o,
                     Finished_o,
                     BranchSelect_o,
                     OpType_o,
                     ALUControl_o);
    
    input logic [3:0] OpCode_i;
    input logic Mem_Finished_i, Exe_Finished_i;
    output logic RegFileWE_o,ExtendSelect_o,ALUSource_o,MemWE_o,OpSource_o,WBSelect_o,Finished_o;
    output logic [1:0] BranchSelect_o, OpType_o, ALUControl_o;
    // OpCode_i: codigo de operacion de la instruccion.
    // BranchSelect_o: selector de la operacion de branch.
    // RegFileWE_o: write enable del banco de registros.
    // ExtendSelect_o: selector de operacion de extension.
    // ALUSource: selector del mux de ALU escalar.
    // OpType_o: codigo de tipos de operandos.
    // ALUControl_o: codigo de operacion de la ALU.
    // MemWE_o: write enable de la memoria de datos.
    // OpSource_o: selector de los mux de etapa memoria.
    // WBSelect_o: selector de los mux del write back.
    
    logic [11:0] OUT;
    
    always_comb begin
        casex (OpCode_i)  //  109876543210
            4'b0000: OUT = 12'b0;  //NOP
            //	 BS R X A OT AC M O W
            4'b0001: OUT = 12'b010110001010;  //Branch
            4'b0010: OUT = 12'b100110001010;  //Branch equal
            4'b0011: OUT = 12'b001000100001;  //Load Scalar
            4'b0100: OUT = 12'b001001100001;  //Load Vector
            4'b0101: OUT = 12'b000000100101;  //Store Scalar
            4'b0110: OUT = 12'b000001100101;  //Store Vector
            4'b0111: OUT = 12'b001001100010;  //Add Vector-Vector
            4'b1000: OUT = 12'b001001000010;  //Add Vector-Scalar
            4'b1001: OUT = 12'b001110100010;  //Add Scalar-Immediate
            4'b1010: OUT = 12'b001000100010;  //Add Scalar-Scalar
            4'b1011: OUT = 12'b001000101010;  //Substract Scalar-Scalar
            4'b1100: OUT = 12'b001001010010;  //Shift Right Vector-Scalar
            4'b1101: OUT = 12'b001001011010;  //Shift Left Vector-Scalar
            4'b1110: OUT = 12'b001000111010;  //Shift Left Scalar-Scalar
            default: OUT = 12'b0;
        endcase
    end
    
    assign BranchSelect_o = OUT[11:10];
    assign RegFileWE_o    = OUT[9];
    assign ExtendSelect_o = OUT[8];
    assign ALUSource_o    = OUT[7];
    assign OpType_o       = OUT[6:5];
    assign ALUControl_o   = OUT[4:3];
    assign MemWE_o        = OUT[2];
    assign OpSource_o     = OUT[1];
    assign WBSelect_o     = OUT[0];
    assign Finished_o     = Mem_Finished_i & Exe_Finished_i;
    
    
endmodule
