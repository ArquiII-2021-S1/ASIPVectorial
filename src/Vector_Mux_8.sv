module Vector_Mux_8 #(I = 20,
                      L = 8)
                     (input [4:0] 			S,
                      input [I-1:0][L-1:0] D16,
                      D17,
                      D18,
                      D19,
                      D20,
                      D21,
                      D22,
                      D23,
                      output [I-1:0][L-1:0] Y);
    
    logic[I-1:0][L-1:0] out;
    
    always_comb begin
        case(S)
            5'b10000: out = D16;
            5'b10001: out = D17;
            5'b10010: out = D18;
            5'b10011: out = D19;
            5'b10100: out = D20;
            5'b10101: out = D21;
            5'b10110: out = D22;
            5'b10111: out = D23;
            default: out  = 0;
        endcase
    end
    
    assign Y = out;
    
endmodule
