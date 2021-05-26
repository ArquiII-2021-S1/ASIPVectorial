module VectorItemExtractor(vector, address, item);
	/* Parameters */
	parameter I = 20;  // Number of items in the vector
	parameter L = 32;  // Item length
	
	/* Input signals */
	input logic [4:0] address;
	input logic [I-1:0][L-1:0] vector;
	output logic [L-1:0] item;

	logic [L-1:0] out;
	
	always_comb begin
		case (address)
			5'd0  : out = vector[0];
			5'd1  : out = vector[1];
			5'd2  : out = vector[2];
			5'd3  : out = vector[3];
			5'd4  : out = vector[4];
			5'd5  : out = vector[5];
			5'd6  : out = vector[6];
			5'd7  : out = vector[7];
			5'd8  : out = vector[8];
			5'd9  : out = vector[9];
			5'd10 : out = vector[10];
			5'd11 : out = vector[11];
			5'd12 : out = vector[12];
			5'd13 : out = vector[13];
			5'd14 : out = vector[14];
			5'd15 : out = vector[15];
			5'd16 : out = vector[16];
			5'd17 : out = vector[17];
			5'd18 : out = vector[18];
			default : out = vector[19];
		endcase
	end
	
	assign item = out;

endmodule 