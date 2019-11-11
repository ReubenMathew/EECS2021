module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
wire[31:0] tempArith,tempAnd,tempOr,slt,tmpRes;
assign slt[31:1] = 0;
assign ex = 0; // not supported
wire cout;

xor(condition, a[31],b[31]);
//a-b in case of slt condition
yArith slt_arith (tmpRes, cout, a, b, 1);
yMux #(.SIZE(1)) slt_mux(slt[0], tmpRes[31], a[31], condition);

and my_and[31:0](tempAnd, a,b);
or my_or[31:0](tempOr, a, b);
yArith my_arith(tempArith,cout,a,b,op[2]);
yMux4to1 #(32) out(z,tempAnd,tempOr,tempArith,slt,op[1:0]);

endmodule