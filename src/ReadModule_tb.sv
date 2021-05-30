module ReadModule_tb();
    
    /* Input signals */
    logic clk, rst, op_type;
    logic [5:0] base_address;
    logic [9:0] read_data;
    
    /* Output signals */
    logic [5:0] read_address;
    logic [9:0] scalar_data;
    logic [20:0][9:0] vector_data;
    
    ReadModule #(20, 10, 6) rdModule(
    .clk(clk),
    .rst(rst),
    .op_type(op_type),
    .base_address(base_address),
    .read_data(read_data),
    .read_address(read_address),
    .scalar_data(scalar_data),
    .vector_data(vector_data)
    );
    
    initial begin
        op_type = 0;
        clk     = 0;
        rst     = 1;
        
        base_address = 6'd34;
        
        read_data = 10'd900;
        
        #10;
        rst = 0;
        #5;
        // Case 1: reading scalar_data
        assert(scalar_data === read_data) else $error("Case 1: scalar_data failed");
        
        // Case 2: reading second position of the array
        op_type   = 1'd1;
        read_data = 10'd901;
        #10;
        assert(read_address === base_address+6'd1) else $error("Case 2: read_address failed");
        assert(vector_data[1] === read_data) else $error("Case 2: vector_data failed");
        
        // Case 3: reading second position of the array
        read_data = 10'd902;
        #10;
        assert(read_address === base_address+6'd2) else $error("Case 3: read_address failed");
        assert(vector_data[2] === read_data) else $error("Case 3: vector_data failed");
        
        // Case 4: reading second position of the array
        read_data = 10'd903;
        #10;
        assert(read_address === base_address+6'd3) else $error("Case 4: read_address failed");
        assert(vector_data[3] === read_data) else $error("Case 4: vector_data failed");
        
        // Case 5: reading second position of the array
        read_data = 10'd904;
        #10;
        assert(read_address === base_address+6'd4) else $error("Case 5: read_address failed");
        assert(vector_data[4] === read_data) else $error("Case 5: vector_data failed");
        
    end
    
    always
    #5 clk = !clk;
    
endmodule
