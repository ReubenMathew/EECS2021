module labM;
reg clk, read, write;
reg [31:0] address, memIn; wire [31:0] memOut;
mem data(memOut, address, memIn, clk, read, write); 

initial
begin
address = 16'h28; write = 0; read = 1; clk = 0;
	repeat (1000)
	begin
		if(memOut[6:0] == 7'h33)  //R 
            $display("R  Type: %h %h %h %h %h %h", memOut[31:25], memOut[24:20], memOut[19:15], memOut[14:12], memOut[11:7], memOut[6:0]);
        
        if(memOut[6:0] == 7'h6F) //UJ 
            $display("UJ Type: %h %h %h", memOut[31:12], memOut[11:7], memOut[6:0]);
        
        if (memOut[6:0] == 7'h3 || memOut[6:0] == 7'h13) //I 
            $display("I  Type: %h %h %h %h", memOut[31:20], memOut[19:15], memOut[14:12], memOut[11:7], memOut[6:0]);
        
        if (memOut[6:0] == 7'h23) //S
            $display("S  Type: %h %h %h %h %h", memOut[31:20], memOut[19:15], memOut[14:12], memOut[11:7], memOut[6:0]);
        
        if (memOut[6:0] == 7'h63) //SB
            $display("SB Type: %h %h %h %h %h %h", memOut[31:25], memOut[24:20], memOut[19:15], memOut[14:12], memOut[11:7], memOut[6:0]);
        #4 address = address + 4;
	end
$finish;
end

always
begin
		#4 clk = ~clk;
end
endmodule