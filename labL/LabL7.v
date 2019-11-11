module labL7;
reg signed [31:0] a, b, expect;
wire signed [31:0] z;
wire cout;
reg ok,cin;
yAdder test(z, cout, a,b,cin);

initial
begin
	repeat (500)
	begin
		a = $random;
		b = $random;
		cin = $random%2;
		#1 expect = a + b + cin;
		ok = 0;
		if (expect === z) ok = 1;
		if (!ok) $display("Module Failed: a=%b b=%b z=%b",a,b,z); 
//		else $display("Module Succeeded: a=%b b=%b z=%b",a,b,z);
	end
end

endmodule