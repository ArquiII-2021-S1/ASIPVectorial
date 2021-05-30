module FinishedSignal(clk,
                      rst,
                      vector_max,
                      op_type,
                      counter,
                      finished);
    
    /* Parameters */
    parameter N = 6;  // Address length
    
    /* Input signals */
    input logic clk, rst, op_type;
    input logic [N-1:0] counter;
    input logic [N-1:0] vector_max;
    
    /* Output signals */
    output logic finished;
    
    initial begin
        finished <= 0;
    end
    
    logic A, B;
    assign A = counter ==  = vector_max;
    assign B = counter ==  = 6'd1;
    
    logic trigger;
    assign trigger = (B && ~op_type) || (A && op_type);
    
    always @(posedge clk) begin
        if (rst) finished <= 0;
        
        else if (trigger) begin
        finished <= 1;
    end
    end
    
endmodule
