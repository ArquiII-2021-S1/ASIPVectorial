module JoinVector_tb();
parameter N = 32, V=20;
logic CLK;
logic RST;
integer counter;
logic 	[4-1:0][N-1:0] vector_i;
logic 	[V-1:0][N-1:0] vector_o;
						
JoinVector #(.N(N), .V(V)) DUT(.*);



always #1 CLK = ~CLK;


initial begin
	CLK=0;
	RST=1;
	counter=0;
	for(integer i=0 ;i < 4; i++)begin
		vector_i[i]=i*5;
	end
	#3;
	counter=1;
	for(integer i=0 ;i < 4; i++)begin
		vector_i[i]=i*5+1;
	end
	#3;
	counter=2;
	for(integer i=0 ;i < 4; i++)begin
		vector_i[i]=i*5+2;
	end
	#3;
	counter=3;
	for(integer i=0 ;i < 4; i++)begin
		vector_i[i]=i*5+3;
	end
	#3;
	counter=4;
	for(integer i=0 ;i < 4; i++)begin
		vector_i[i]=i*5+4;
	end
	#3;
end


endmodule