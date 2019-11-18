module yMux1(z,a,b,c);
output z;
input a, b, c;
wire notC, upper, lower;

not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);

endmodule

module yMux4to1(z, a0,a1,a2,a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;
wire [SIZE-1:0] zLo, zHi;
yMux #(SIZE) lo(zLo, a0, a1, c[0]);
yMux #(SIZE) hi(zHi, a2, a3, c[0]);
yMux #(SIZE) final(z, zLo, zHi, c[1]);
endmodule
module yAdder1(z, cout, a, b, cin);
output z, cout;
input a, b, cin;
xor left_xor(tmp, a, b);
xor right_xor(z, cin, tmp);
and left_and(outL, a, b);
and right_and(outR, tmp, cin);
or my_or(cout, outR, outL);
endmodule
module yAdder(z, cout, a, b, cin);
output [31:0] z;
output cout;
input [31:0] a, b;
input cin;
wire[31:0] in, out;
yAdder1 mine[31:0](z, out, a, b, in);
assign in[0] = cin;
assign in[31:1] = out[30:0];
assign cout = out[31];
endmodule
module yArith(z, cout, a, b, ctrl);
// add if ctrl=0, subtract if ctrl=1
output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire[31:0] notB, tmp;
wire cin;

assign cin = ctrl;
not notCase [31:0] (notB, b);

yMux #(32) choice(tmp, b, notB, cin);
yAdder adder(z, cout, a, tmp, cin);

endmodule
module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
wire[31:0] tempArith,tempAnd,tempOr,slt,tmpRes;
assign slt[31:1] = 0;
assign ex = 0; // not supported
wire cout;

wire [15:0] z16;
wire [7:0] z8;
wire [3:0] z4;
wire [1:0] z2;
wire z1,z0;

or or16[15:0] (z16, z[15: 0], z[31:16]);
or or8[7:0] (z8, z16[7: 0], z16[15:8]);
or or4[3:0] (z4, z8[3: 0], z8[7:4]);
or or2[1:0] (z2, z4[1:0], z4[3:2]);
or or1[15:0] (z1, z2[1], z2[0]);
not m_not (z0, z1);
assign ex = z0;

xor(condition, a[31],b[31]);
//a-b in case of slt condition
yArith slt_arith (tmpRes, cout, a, b, 1'd1);
yMux #(1) slt_mux(slt[0], tmpRes[31], a[31], condition);

and my_and[31:0](tempAnd, a,b);
or my_or[31:0](tempOr, a, b);
yArith my_arith(tempArith,cout,a,b,op[2]);
yMux4to1 #(32) out(z,tempAnd,tempOr,tempArith,slt,op[1:0]);

endmodule
module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;

yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule

module yIF(ins, PCp4, PCin, clk);
output [31:0] ins, PCp4; input [31:0] PCin;
input clk;
wire ex;
wire[31:0] PCRegOut,memIn;

assign memIn = 0;

register #(32) r(PCRegOut,PCin,clk,1'b1);
yAlu alu(PCp4,ex,4,PCRegOut,3'b010);
mem m(ins, PCRegOut, memIn,clk, 1'b1, 1'b0);


endmodule