module WriteEnable(op_type, base_address, write_address, we_control_unit, write_enable);
	parameter N = 10;
	
	input logic op_type, we_control_unit;
	input logic[N-1:0] base_address, write_address;
	output logic write_enable;

	logic vec_comp;
	
	assign vec_comp = (write_address > (base_address+5'd19));
	
	assign write_enable = (~vec_comp || ~op_type) && we_control_unit;

endmodule 