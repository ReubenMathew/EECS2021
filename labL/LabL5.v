module labL5;
reg a,b,cin;
wire z,cout;
integer i, j, k;
reg[1:0] sum;
yAdder A(z,cout,a,b,cin);

initial
begin
	for (i = 0; i < 2; i = i + 1)
		begin
		for (j = 0; j < 2; j = j + 1)
			begin
			for (k = 0; k < 2; k = k + 1)
				begin
					a = i; b = j; cin = k;
		 			sum = a+b+cin;
		 			if (sum[31] != cout)
		 				#1 $display("a=%b b=%b cin=%b z=%b", a, b, cin, cout, z);
		 			if (sum[0] != z)
		 				#1 $display("a=%b b=%b cin=%b z=%b", a, b, cin, cout, z);
	 			end
			end
		end
		#5 $display("a=%b b=%b cin=%b z=%b cout=%b sum=%b", a, b, cin, z, cout, sum);
$finish;
end

endmodule