module yMux2(z, a, b, c);
output [1:0] z;
input [1:0] a, b;
input c;
yMux1 upper(z[0], a[0], b[0], c);
yMux1 lower(z[1], a[1], b[1], c);
endmodule

module yMux1(z,a,b,c);
output z;
input a, b, c;
wire notC, upper, lower;

not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);

endmodule