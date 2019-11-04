module labL3;
reg[31:0] a,b;
reg c;
wire[31:0] z;
integer i, j, k;

defparam M.SIZE = 32;
yMux M(z,a,b,c);

initial
begin
	repeat (100)
	begin
		a = $random;
		b = $random;
		c = $random % 2;
		#1;
		#5 $display("a=%b b=%b c=%b z=%b", a, b, c, z);
	end
$finish;
end

endmodule