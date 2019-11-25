module labM;
reg [31:0] PCin;
reg RegWrite, clk, ALUSrc, MemRead,MemWrite, Mem2Reg;
reg [2:0] op;
wire [31:0] wd, rd1,branch, rd2, imm, ins, PCp4, z,memOut,wb;
wire [31:0] jTarget;
wire zero;


yIF myIF(ins, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;

initial 
  begin
  //------------------------------------Entry point 
  PCin = 16'h28;

  //------------------------------------Run program
  repeat (43) 
    begin

    //---------------------------------Fetch an ins

    clk = 1; #1;
    //---------------------------------Set control signals 
    RegWrite = 0; ALUSrc = 1; op = 3'b010;
    // Add statements to adjust the above defaults
    if(ins[6:0]==7'h33)//R-Type
    begin
        RegWrite=1; ALUSrc=0; MemRead = 0; 
        MemWrite = 0; Mem2Reg = 0;
        //$display("%b",ins[14:12]);
        if (ins[14:12] == 3'b110)
          begin
          op = 3'b001;
          end
        else if(ins[14:12]== 3'b000)
        begin
          op = 3'b010;
          
        end
    end

    if(ins[6:0]==7'h6f)//UJ-Type 
    begin
        RegWrite=1; ALUSrc=1;
        MemRead = 0; MemWrite = 0; Mem2Reg = 0;
        //$display("UJ jump: JAL");
    end



    if(ins[6:0]==7'h3)//I_type
    begin
        RegWrite=1; ALUSrc=1; 
        MemRead = 1; MemWrite = 0; Mem2Reg = 1;

    //    #4 $display(" I Type: ins=%h: rd1=%2h rd2=%2h  wb=%2d", ins[11:7], rd1, rd2, wb);
    end

    if(ins[6:0] == 7'h13)//I_type ADDI
    begin
        RegWrite=1; ALUSrc=1; 
        MemRead = 0; MemWrite = 0; Mem2Reg = 0;

    //    #4 $display(" I Type: ins=%h: rd1=%2h rd2=%2h  wb=%2d", ins[11:7], rd1, rd2, wb);
    end

    if(ins[6:0]==7'h23)//S-type
    begin
        RegWrite=0; ALUSrc=1; //op=3'b010;
        MemRead = 0; MemWrite = 1; Mem2Reg = 0;
    end

    if(ins[6:0]==7'h63)// SB-type
    begin
        RegWrite=0; ALUSrc=0;
        MemRead = 0; MemWrite = 0; Mem2Reg = 0;
       // $display("BEQ");
    end
    //---------------------------------Execute the ins
    clk = 0; #1;
    //---------------------------------View results
    //$display("ins=%h rd1=%h rd2=%h imm=%d jTarget=%h z=%h zero=%h",ins,rd1,rd2,imm,jTarget,z,zero);
    #4 $display("%h: rd1=%2d rd2=%2d z= %1d zero=%b wb=%2d", ins, rd1, rd2, z, zero, wb);
    //---------------------------------Prepare for the next ins
    if (ins[6:0] == 7'b1100011 && zero == 1)
      begin
      PCin = PCin + (imm << 1) ; 
      end
    else if (ins[6:0] == 7'b1101111)
      begin
      PCin = PCin + (jTarget << 2);
      //$display("LOOP: %h", PCin); 
      end
    else
      begin
      PCin = PCp4;
      //$display("%h",PCin);
      end


    end
  end
endmodule
