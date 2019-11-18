module labM;

reg clk, read, write;
reg [31:0] address, memIn;
wire [31:0] memOut;

mem data(memOut, address, memIn, clk, read, write);

initial
begin

    #1 write = 1; read = 0; address = 16; 
    	clk = 0;
    memIn = 32'h12345678;
    clk = 1;

    #1 address = address + 8; 
    memIn = 32'h89abcdef;
    read = 1; address = 16;
    clk = 0;


	repeat (3) 
	begin
		#1 $display("Address %d contains %h", address, memOut); address = address + 4;
	end
$finish;
end

always
begin
		#4 clk = ~clk;
end

endmodule