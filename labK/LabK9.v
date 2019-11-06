module labK;
reg a,b,c,out1,out2;
reg[1:0] expect;
wire z,cout,temp1,temp2,temp3;
integer i,j,k;

xor first_xor(temp1,a,b);
and first_and(temp2,a,b);

xor second_xor(z,c,temp1);
and second_and(temp3,c,temp1);
or final(cout,temp3,temp2);

initial
begin
    for(i=0;i<2;i=i+1)
    begin
        for(j=0;j<2;j=j+1)
            begin
            for(k=0;k<2;k=k+1)
                begin
                       a=i; b=j; c=k;
                       #1;
                        expect=a+b+c;
                        if (expect[0]===z && expect[1]===cout)
                        $display("PASS: a=%b b=%b z=%b", a, b, z);
                        else
                        $display("FAIL: a=%b b=%b z=%b", a, b, z);
                end
            end
    end
end

endmodule