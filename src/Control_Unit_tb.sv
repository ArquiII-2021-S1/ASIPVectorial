module Control_Unit_tb();
    
    logic [3:0] OpCode;
    logic 	   Mem_Finished, Exe_Finished;
    logic       RegFileWE, ExtendSelect, ALUSource, MemWE, WBSelect, OpSource, Finished;
    logic [1:0] BranchSelect, OpType, ALUControl;
    
    Control_Unit DUT(OpCode, Mem_Finished, Exe_Finished, RegFileWE, ExtendSelect, ALUSource, MemWE, OpSource, WBSelect, Finished, BranchSelect, OpType, ALUControl);
    
    initial begin
        OpCode       = 4'b0000;
        Mem_Finished = 0;
        Exe_Finished = 0;
        #10;
        
        OpCode = 4'b0001;
        #10;
        
        OpCode = 4'b0010;
        #10;
        
        OpCode = 4'b0011;
        #10;
        
        OpCode = 4'b0100;
        #10;
        
        OpCode = 4'b0101;
        #10;
        
        OpCode = 4'b0110;
        #10;
        
        OpCode = 4'b0111;
        #10;
        
        OpCode = 4'b1000;
        #10;
        
        OpCode = 4'b1001;
        #10;
        
        OpCode = 4'b1010;
        #10;
        
        OpCode = 4'b1011;
        #10;
        
        OpCode = 4'b1100;
        #10;
        
        Mem_Finished = 1;
        Exe_Finished = 1;
        #10;
        
    end
    
endmodule
