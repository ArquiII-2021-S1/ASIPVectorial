module Vector_Mux_2 #(I=20, L=8)(input  				    WBSelect,
											input  [I-1:0][L-1:0] Vector_Data, ALUResult_Vector_Data,
											output [I-1:0][L-1:0] WD3_VEC);

	logic[I-1:0][L-1:0] OUT;	
								
	always_comb begin
		case(WBSelect)
			4'b0: OUT = Vector_Data;
			4'b1: OUT = ALUResult_Vector_Data;
			default: OUT = 0;
		endcase
	end

	assign WD3_VEC = OUT;

endmodule