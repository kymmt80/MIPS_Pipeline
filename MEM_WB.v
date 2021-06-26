module MEM_WB(input clk,rst,Reg_Write_MEM,memToReg_MEM,writePC_MEM,input[4:0]Write_Reg_MEM,input [31:0] ALUout_MEM,readDataMem_MEM,PC_MEM,output reg Reg_Write_WB,memToReg_WB,writePC_WB,output reg [4:0]Write_Reg_WB,output reg [31:0] ALUout_WB,readDataMem_WB,PC_WB);
always@(posedge clk,posedge rst)begin
    if(rst)begin
        Reg_Write_WB<=0;
        memToReg_WB<=0;
        writePC_WB<=0;
        Write_Reg_WB<=0;
        ALUout_WB<=0;
        readDataMem_WB<=0;
        PC_WB<=0;
    end
    else begin
        Reg_Write_WB<=Reg_Write_MEM;
        memToReg_WB<=memToReg_MEM;
        writePC_WB<=writePC_MEM;
        Write_Reg_WB<=Write_Reg_MEM;
        ALUout_WB<=ALUout_MEM;
        readDataMem_WB<=readDataMem_MEM;
        PC_WB<=PC_MEM;
    end
end

endmodule