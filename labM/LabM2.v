module labM;

wire [31:0] z;
reg [31:0] d;
reg clk, enable, flag;

register #(32) r(z,d,clk,enable);

initial
begin
	flag = $value$plusargs("enable=%b", enable);
	clk = 0;
	repeat (20)
	begin
		#2 d = $random;
		#5 clk = ~clk; 
		#1 $monitor("%5d clk=%b d=%d, z=%d",$time, clk, d, z);
	end
end


endmodule
