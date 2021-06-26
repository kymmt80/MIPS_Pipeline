module EX_MEM(input clk,rst,Reg_Write_EX,memWrite_EX,memRead_EX,memToReg_EX,writePC_EX,input [4:0]Write_Reg_EX,input [31:0] Read_Data2_EX,ALUout_EX,PC_EX,output reg Reg_Write_MEM,memWrite_MEM,memRead_MEM,memToReg_MEM,writePC_MEM,output reg[4:0]Write_Reg_MEM,output reg [31:0] Read_Data2_MEM,ALUout_MEM,PC_MEM);
always@(posedge clk,posedge rst)begin
    if(rst)begin
        Reg_Write_MEM<=0;
        memWrite_MEM<=0;
        memRead_MEM<=0;
        memToReg_MEM<=0;
        writePC_MEM<=0;
        Read_Data2_MEM<=0;
        ALUout_MEM<=0;
        Write_Reg_MEM<=0;
        PC_MEM<=0;
    end
    else begin
        Reg_Write_MEM<=Reg_Write_EX;
        memWrite_MEM<=memWrite_EX;
        memRead_MEM<=memRead_EX;
        memToReg_MEM<=memToReg_EX;
        writePC_MEM<=writePC_EX;
        Read_Data2_MEM<=Read_Data2_EX;
        ALUout_MEM<=ALUout_EX;
        Write_Reg_MEM<=Write_Reg_EX;
        PC_MEM<=PC_EX;
    end
end

endmodule