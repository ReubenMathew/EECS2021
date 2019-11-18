module labM;
reg clk, read, write;
reg [31:0] address, memIn; wire [31:0] memOut;
mem data(memOut, address, memIn, clk, read, write); 

initial
begin
address = 16'h28; write = 0; read = 1;
	repeat (11)
	begin
		#10 $display("%h at address=%d",memOut,address);
		address = address +4;
	end
$finish;
end

always
begin
		#10 clk = ~clk;
end
endmodule