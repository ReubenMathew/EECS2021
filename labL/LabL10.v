module labL9;
reg signed [31:0] a, b;
reg [31:0] expect;
reg [2:0] op;
wire ex;
wire [31:0] z;
reg ok, flag;
yAlu mine(z, ex, a, b, op);

initial
begin
	repeat (100)
	begin

		a = $random;
		b = $random;
		op = $random%7;
		// The oracle: compute "expect" based on "op"
		#10;
		if(op==0) begin
			expect = a&b;
			$display("AND: expect=%d actual=%d",expect,z);
		end else if(op==1) begin
			expect = a|b;
			$display("OR: expect=%d actual=%d",expect,z);
		end else if(op==2) begin
			expect = a+b;
			$display("SUB: expect=%d actual=%d",expect,z);
		end else if(op==6) begin
			expect = a-b;
			$display("ADD: expect=%d actual=%d",expect,z);
		end else if (op == 3'b111) begin
			expect = (a < b) ? 1 : 0;
			$display("SLT: expect=%d actual=%d",expect,z);
		end
		
	end
$finish;
end
endmodule