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