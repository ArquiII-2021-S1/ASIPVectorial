module Scalar_Mux_2 #(N=32)(input  		    WBSelect,
									 input  [N-1:0] Scalar_Data, ALUResult_Scalar_Data,
									 output [N-1:0] WD3_SCA);

	logic[N-1:0] OUT;	
								
	always_comb begin
		case(WBSelect)
			1'b0: OUT = Scalar_Data;
			1'b1: OUT = ALUResult_Scalar_Data;
			default: OUT = 0;
		endcase
	end

	assign WD3_SCA = OUT;

endmodule