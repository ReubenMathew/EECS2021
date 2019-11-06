module kabK;
reg a,b,c,expect;
wire temp1,temp2,temp3,z;

not my_not(temp1,c);
and first_and(temp2,temp1,a);
and second_and(temp3,c,b);
or final(z,temp2,temp3);

initial
begin
    a=1; b=0; c=0;
    expect=1;
    #1;
    if(expect===z)
    $display("PASS: a=%b b=%b z=%b", a, b, z);
    else
    $display("FAIL: a=%b b=%b z=%b", a, b, z);
    $finish;
end

endmodule