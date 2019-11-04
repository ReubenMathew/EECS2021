module labL3;
reg[31:0] a0,a1,a2,a3;
reg [1:0]c;
wire[31:0] z;
integer i, j, k;

defparam M.SIZE = 32;
yMux4to1 M(z,a0,a1,a2,a3,c);

initial
begin
	repeat (10)
	begin
		a0 = $random;
		a1 = $random;
		a2 = $random;
		a3 = $random;
		c = $random % 4;
		#1;
		#5 $display("a0=%b a1=%b a2=%b c=%b z=%b", a0, a1, a2, a3, c, z);
	end
$finish;
end

endmodule