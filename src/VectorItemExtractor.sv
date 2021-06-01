module VectorItemExtractor(vector,
                           address,
                           item);
    /* Parameters */
    parameter I = 20;  // Number of items in the vector
    parameter L = 32;  // Item length
    
    /* Input signals */
    input logic [4:0] address;
    input logic [I-1:0][L-1:0] vector;
    output logic [L-1:0] item;
    
    always_comb begin
        case (address)
            5'd0  : item   <= vector[0];
            5'd1  : item   <= vector[1];
            5'd2  : item   <= vector[2];
            5'd3  : item   <= vector[3];
            5'd4  : item   <= vector[4];
            5'd5  : item   <= vector[5];
            5'd6  : item   <= vector[6];
            5'd7  : item   <= vector[7];
            5'd8  : item   <= vector[8];
            5'd9  : item   <= vector[9];
            5'd10 : item   <= vector[10];
            5'd11 : item   <= vector[11];
            5'd12 : item   <= vector[12];
            5'd13 : item   <= vector[13];
            5'd14 : item   <= vector[14];
            5'd15 : item   <= vector[15];
            5'd16 : item   <= vector[16];
            5'd17 : item   <= vector[17];
            5'd18 : item   <= vector[18];
            default : item <= vector[19];
        endcase
    end
    
endmodule
