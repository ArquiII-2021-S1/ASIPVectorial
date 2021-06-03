module JoinVector #(parameter L = 8,
                    V = 20)
                   (input logic CLK,
                    input logic RST,
                    input integer counter,
                    input logic 	[4-1:0][L-1:0] vector_i,
                    output logic 	[V-1:0][L-1:0] vector_o);
    
    always @(negedge (CLK))begin
        vector_o[counter]    = vector_i[0];
        vector_o[counter+5]  = vector_i[1];
        vector_o[counter+10] = vector_i[2];
        vector_o[counter+15] = vector_i[3];
        
    end
    
    
    
    //genvar i;
    //generate
    //for (i = 0; i<V; i = i+1) begin: generate_vectors
    //		assign vector_o[i] = scalar_i;
    //end
    //endgenerate
endmodule
