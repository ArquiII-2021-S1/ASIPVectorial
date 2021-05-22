module Scalar_Mux_8 #(N=4)(input  [3:0]   S,
									input  [N-1:0] D00, D01, D02, D03, D04, D05, D06, D07,
									output [N-1:0] Y);

logic[N-1:0] out;	
							
always_comb begin
	case(S)
		4'b0000: out = D00;
		4'b0001: out = D01;
		4'b0010: out = D02;
		4'b0011: out = D03;
		4'b0100: out = D04;
		4'b0101: out = D05;
		4'b0110: out = D06;
		4'b0111: out = D07;
		default: out = 0;
	endcase
end

assign Y = out;

endmodule