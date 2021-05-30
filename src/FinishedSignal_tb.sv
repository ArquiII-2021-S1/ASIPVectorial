module FinishedSignal_tb();
    
    /* Input signals */
    logic clk, rst, op_type;
    logic [5:0] counter;
    
    /* Output signals */
    logic finished;
    
    FinishedSignal #(6) finishedSignal(
    .clk(clk),
    .rst(rst),
    .vector_max(6'd19),
    .op_type(op_type),
    .counter(counter),
    .finished(finished)
    );
    
    initial begin
        clk     = 1'b0;
        rst     = 1'b0;
        op_type = 1'b0;
        counter = 6'd0;
        #10;
        
        // Case 1: scalar operation
        assert(finished ==  = 1'b0) else $error("Case 1: cycle 1 failed");
        counter         = 6'd1;
        #10;
        
        assert(finished ==  = 1'b1) else $error("Case 1: cycle 2 failed");
        #10;
        rst = 1'b1;
        #10;
        rst = 1'b0;
        
        // Case 2: vector operation, counter not 20
        op_type = 1'b1;
        #10;
        assert(finished ==  = 1'b0) else $error("Case 2 failed");
        #10;
        rst = 1'b1;
        #10;
        rst = 1'b0;
        
        // Case 3: vector operation, counter not 20
        op_type = 1'b1;
        counter = 6'd15;
        #10;
        assert(finished ==  = 1'b0) else $error("Case 3 failed");
        #10;
        rst = 1'b1;
        #10;
        rst = 1'b0;
        
        // Case 4: vector operation, counter not 20
        op_type = 1'b1;
        counter = 6'd19;
        #10;
        assert(finished ==  = 1'b0) else $error("Case 4 failed");
        #10;
        rst = 1'b1;
        #10;
        rst = 1'b0;
        
        // Case 5: vector operation, counter 20
        op_type = 1'b1;
        counter = 6'd20;
        #10;
        assert(finished ==  = 1'b1) else $error("Case 5 failed");
        #10;
        
        // Case 6: vector operation, counter greater than 20 without reset
        op_type = 1'b1;
        counter = 6'd25;
        #10;
        assert(finished ==  = 1'b1) else $error("Case 6 failed");
        #10;
        rst = 1'b1;
        #10;
        rst = 1'b0;
        
    end
    
    always
    #5 clk = !clk;
    
endmodule
