module ID_EX(input clk,rst, Reg_Write_ID,memWrite_ID,memRead_ID,RegDst_ID,ALUsrc_ID,memToReg_ID,link31_ID,writePC_ID,Jmp_ID,PCsrc_ID,branch_ID,decide_br_ID,input [2:0]ALU_control_ID,input [31:0]Read_Data1_ID,Read_Data2_ID,inst_ID,PC_ID,output reg Reg_Write_EX,memWrite_EX,memRead_EX,RegDst_EX,ALUsrc_EX,memToReg_EX,link31_EX,writePC_EX,Jmp_EX,PCsrc_EX,branch_EX,decide_br_EX,output reg [2:0]ALU_control_EX,output reg [31:0]Read_Data1_EX,Read_Data2_EX,inst_EX,PC_EX);

always@(posedge clk,posedge rst)begin
    if(rst)begin
        Reg_Write_EX<=0;
        memWrite_EX<=0;
        memRead_EX<=0;
        RegDst_EX<=0;
        ALUsrc_EX<=0;
        memToReg_EX<=0;
        link31_EX<=0;
        writePC_EX<=0;
        ALU_control_EX<=3'b000;
        Read_Data1_EX<=0;
        Read_Data2_EX<=0;
        inst_EX<=0;
        PC_EX<=0;
        Jmp_EX<=0;
        PCsrc_EX<=0;
        branch_EX<=0;
        decide_br_EX<=0;
    end
    else begin
        Reg_Write_EX<=Reg_Write_ID;
        memWrite_EX<=memWrite_ID;
        memRead_EX<=memRead_ID;
        RegDst_EX<=RegDst_ID;
        ALUsrc_EX<=ALUsrc_ID;
        memToReg_EX<=memToReg_ID;
        link31_EX<=link31_ID;
        writePC_EX<=writePC_ID;
        ALU_control_EX<=ALU_control_ID;
        Read_Data1_EX<=Read_Data1_ID;
        Read_Data2_EX<=Read_Data2_ID;
        inst_EX<=inst_ID;
        PC_EX<=PC_ID;
        Jmp_EX<=Jmp_ID;
        PCsrc_EX<=Jmp_ID;
        branch_EX<=branch_ID;
        decide_br_EX<=decide_br_ID;
    end
end

endmodule