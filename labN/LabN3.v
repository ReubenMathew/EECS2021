module labN;

reg  clk,  INT;
reg [2:0] op;
reg[31:0] branchImm,jImm,entryPoint;
wire [31:0] PCin;
wire [31:0] wd, rd1,branch, rd2, imm, ins, PCp4, PC, z,memOut,wb,jTarget,exeOut;
wire zero;
wire isStype, isRtype, isItype, isLw, isjump, isbranch, RegWrite,ALUSrc, MemRead,MemWrite, Mem2Reg;
wire[6:0] opCode;
yIF myIF(ins, PC, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(exeOut, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, exeOut, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, exeOut, memOut, Mem2Reg);
assign wd = wb;
yPC myPC(PCin, PC, PCp4, INT, entryPoint, branch, jTarget, zero, isbranch, isjump);
assign opCode = ins[6:0];
yC1 myC1(isStype, isRtype, isItype, isLw, isjump, isbranch, opCode);
yC2 myC2(RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isStype, isRtype, isItype, isLw, isjump, isbranch);

assign wd = wb;

initial 
  begin
  //------------------------------------Entry point 
  entryPoint = 32'h28; INT = 1; #1;
  //------------------------------------Run program
  repeat (43) 
    begin
    op = 3'b010;
    //---------------------------------Fetch an ins
    if(isRtype == 1)//R-Type
    begin
        $display("%b",ins[14:12]);
        if (ins[14:12] == 3'b110)
          begin
          op = 3'b001;
          end
        else if(ins[14:12]== 3'b000)
        begin
          op = 3'b010;
          
        end
    end

    clk = 1; #1; INT = 0;

    //---------------------------------Execute the ins
    clk = 0; #1;
    //---------------------------------View results
    //$display("ins=%h rd1=%h rd2=%h imm=%d jTarget=%h z=%h zero=%h",ins,rd1,rd2,imm,jTarget,z,zero);
    #4 $display("%h: rd1=%2d rd2=%2d exeOut= %1d zero=%b wb=%2d", ins, rd1, rd2, exeOut, zero, wb);
    //---------------------------------Prepare for the next ins
  

    end
  end
endmodule


