module Scalar_Mux_16 #(N = 4)
                      (input [4:0] S,
                       input [N-1:0] D00,
                       D01,
                       D02,
                       D03,
                       D04,
                       D05,
                       D06,
                       D07,
                       D08,
                       D09,
                       D10,
                       D11,
                       D12,
                       D13,
                       D14,
                       D15,
                       output [N-1:0] Y);
    
    logic[N-1:0] out;
    
    always_comb begin
        case(S)
            5'b00000: out = D00;
            5'b00001: out = D01;
            5'b00010: out = D02;
            5'b00011: out = D03;
            5'b00100: out = D04;
            5'b00101: out = D05;
            5'b00110: out = D06;
            5'b00111: out = D07;
            5'b01000: out = D08;
            5'b01001: out = D09;
            5'b01010: out = D10;
            5'b01011: out = D11;
            5'b01100: out = D12;
            5'b01101: out = D13;
            5'b01110: out = D14;
            5'b01111: out = D15;
            default: out  = 0;
        endcase
    end
    
    assign Y = out;
    
endmodule
