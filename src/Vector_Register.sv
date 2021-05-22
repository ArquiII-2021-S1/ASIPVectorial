module Vector_Register #(I=20, L=8) (input  logic CLK, RST, EN,
												 input  logic [I-1:0] [L-1:0] Data_In,
												 output logic [I-1:0] [L-1:0] Data_Out);
								
	logic [I-1:0] [L-1:0] OUT = 0;

	always_ff @(negedge CLK) begin
		if      (RST) OUT <= 0;
		else if (EN) OUT <= Data_In;
	end

	assign Data_Out = OUT;

endmodule 