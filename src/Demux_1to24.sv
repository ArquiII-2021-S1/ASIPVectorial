module Demux_1to24 (input IN,
                    input [4:0] S,
                    output [23:0] OUT);
    
    logic[23:0] out = 0;
    
    always_comb begin
        out = 0;
        case(S)
            5'b00000: out[0]  = IN;
            5'b00001: out[1]  = IN;
            5'b00010: out[2]  = IN;
            5'b00011: out[3]  = IN;
            5'b00100: out[4]  = IN;
            5'b00101: out[5]  = IN;
            5'b00110: out[6]  = IN;
            5'b00111: out[7]  = IN;
            5'b01000: out[8]  = IN;
            5'b01001: out[9]  = IN;
            5'b01010: out[10] = IN;
            5'b01011: out[11] = IN;
            5'b01100: out[12] = IN;
            5'b01101: out[13] = IN;
            5'b01110: out[14] = IN;
            5'b01111: out[15] = IN;
            5'b10000: out[16] = IN;
            5'b10001: out[17] = IN;
            5'b10010: out[18] = IN;
            5'b10011: out[19] = IN;
            5'b10100: out[20] = IN;
            5'b10101: out[21] = IN;
            5'b10110: out[22] = IN;
            5'b10111: out[23] = IN;
            default: out      = 0;
        endcase
    end
    
    assign OUT = out;
    
endmodule
