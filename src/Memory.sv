module Memory(clk, address, write_data, write_enable, read_data);

	/* Parameters */
	parameter A = 32; // Address length
	parameter L = 8;	// Data length
	
	/* Inputs */
	input logic clk;
	input logic [A-1:0] address;
	input logic [L-1:0] write_data;
	input logic write_enable;
	
	/* Outputs */
	output logic [L-1:0] read_data;
	
	// Read memory signals
	logic [A-1:0] ram_address;
	logic [(A/2)-1:0] rom_address;
	assign ram_address = address - 32'hFFFF;
	assign rom_address = address[(A/2)-1:0];
	
	
	logic [L-1:0] ram_data;
	logic [L-1:0] rom_data;
	
	ROM rom(
		.address(address),
		.clock(clk),
		.q(rom_data)
	);
	
	RAM ram(
		.address(ram_address),
		.clock(clk),
		.data(write_data),
		.wren(write_enable),
		.q(ram_data)
	);
	
	// Chipset
	logic selector;
	assign selector = address < {{(A/2){1'b0}},{(A/2){1'b1}}};
	assign read_data = selector ? rom_data : ram_data;
	
endmodule 