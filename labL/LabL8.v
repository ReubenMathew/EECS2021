module labL8;
reg signed [31:0] a,b,correct;
reg ctrl;
wire signed [31:0] z;
wire cout;

yArith yTest(z,cout,a,b,ctrl);

initial
begin
	repeat(1000)
	begin
		#1 a = $random;
		#1 b = $random;
		#1 ctrl = $random % 2;
		#1 correct = ctrl ? (a - b) : (a+b);

		if (!(correct === z)) $display("Module failed: z=%d expected=%d",z,correct);
		
	end
	$finish;
end

endmodule