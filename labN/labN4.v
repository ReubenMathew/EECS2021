module labN;

reg[31:0] entryPoint;
reg clk, INT, 
wire[31:0] ins, rd2, wb;
yChip myChip(ins,rd2,wb,entryPoint,INT,clk);

yChip myChip(ins,rd2,wb,entryPoint,INT,clk)