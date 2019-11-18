module labM;
reg [31:0] wd;
reg [4:0] rs1, rs2, wn;
wire[31:0] rd1, rd2;
integer i;
reg clk, w, flag;

rf myRF(rd1, rd2, rs1, rs2, wn, wd, clk, w);

initial
begin
	flag = $value$plusargs("w=%b", w);
	clk = 0;
	for(i = 0; i < 32; i = i + 1)
	begin
		wd = i * i;
		wn = i;
		#10 rs1 = wn;
		#5 clk = ~clk;
		$display("clk=%b rd1=%d, wd=%d, wn=%d", clk, rd1, wd, wn);

	end
end

endmodule