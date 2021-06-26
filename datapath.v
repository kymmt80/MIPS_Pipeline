module datapath(input clk,rst,Reg_Write,memWrite,memRead,RegDst,ALUsrc,memToReg,Jmp,link31,writePC,Jumpinp,branch,decide_br,input [2:0]ALU_control,output [31:0]inst_ID,output Zero);
    wire [31:0]writeData,regAddress,instAddress,readDataMem,Write_Data,Read_Data1, Read_Data2,ALUin2,ALUin1,NotForwardBin,ALUout,PCsrcIn,addIn,branchIn,notJmp,memData,Jump;
    wire [31:0] inst,PC_ID;
    wire [4:0]Read_Reg1, Read_Reg2, Write_Reg,outReg;
    wire Reg_Write_ID,memWrite_ID,memRead_ID,RegDst_ID,ALUsrc_ID,memToReg_ID,link31_ID,writePC_ID,Jmp_ID,PCsrc_ID,branch_ID,decide_br_ID;
    wire Reg_Write_EX,memWrite_EX,memRead_EX,RegDst_EX,ALUsrc_EX,memToReg_EX,link31_EX,writePC_EX,Jmp_EX,PCsrc_EX,branch_EX,decide_br_EX;
    wire [2:0]ALU_control_EX,ALU_control_ID;
    wire [31:0]Read_Data1_EX,Read_Data2_EX,inst_EX,PC_EX;
    wire Reg_Write_MEM,memWrite_MEM,memRead_MEM,memToReg_MEM,writePC_MEM;
    wire [31:0]Read_Data2_MEM,ALUout_MEM,PC_MEM;
    wire [4:0]Write_Reg_MEM;
    wire Reg_Write_WB,memToReg_WB,writePC_WB;
    wire [4:0]Write_Reg_WB;
    wire [31:0] ALUout_WB,readDataMem_WB,PC_WB;
    wire [1:0]ForwardA,ForwardB;
    wire clr_control,IF_ID_write,PC_write,branchCond,PCsrc,eq,IF_FLUSH;

    //IF____________________________________________

    register PC(
        .clk(clk),
        .ld(PC_write),
        .rst(rst),
        .Qin(PCsrcIn),
        .Q(instAddress)
    );

    inst_mem im(
        .Address(instAddress),
        .inst(inst)
    );

    adder incrementer(
        .a(instAddress),
        .b(32'd4),
        .res(addIn)
    );

    //end IF________________________________________
    //or(IF_FLUSH,rst,PCsrc,Jmp_EX);
    ControlHazard ch(clk,rst,PCsrc_EX,Jmp_EX,IF_FLUSH);
    IF_ID If_Id(
        .clk(clk),
        .rst(IF_FLUSH),
        .ld(IF_ID_write),
        .PC_IF(addIn),
        .inst_IF(inst),
        .inst_ID(inst_ID),
        .PC_ID(PC_ID)
    );

    //ID____________________________________________
    assign eq=(Read_Data1==Read_Data2)?1:0;
    and a1(PCsrc,branch_ID,(decide_br_ID==eq));

    adder branchAdd(
        .a(PC_ID),
        .b({{14{inst_ID[15]}},inst_ID[15:0],2'b00}),
        .res(branchIn)
    );

    mux2nton branchmux(
        .a(addIn),
        .b(branchIn),
        .o(notJmp),
        .s(PCsrc)
    );

    mux2nton Jumpinmux(
        .a({PC_ID[31:28],inst_ID[25:0],2'b00}),
        .b(Read_Data1),
        .o(Jump),
        .s(Jumpinp)
    );

    mux2nton Jmpmux(
        .a(notJmp),
        .b(Jump),
        .o(PCsrcIn),
        .s(Jmp)
    );

    register_file rf(
        .clk(clk),
        .Reg_Write(Reg_Write_WB),
        .Read_Reg1(inst_ID[25:21]),
        .Read_Reg2(inst_ID[20:16]),
        .Write_Reg(Write_Reg_WB),
        .Write_Data(Write_Data),
        .Read_Data1(Read_Data1),
        .Read_Data2(Read_Data2)
    );

    assign Reg_Write_ID=(clr_control)?0:Reg_Write;
    assign memWrite_ID=(clr_control)?0:memWrite;
    assign memRead_ID=(clr_control)?0:memRead;
    assign RegDst_ID=(clr_control)?0:RegDst;
    assign ALUsrc_ID=(clr_control)?0:ALUsrc;
    assign memToReg_ID=(clr_control)?0:memToReg;
    assign link31_ID=(clr_control)?0:link31;
    assign writePC_ID=(clr_control)?0:writePC;
    assign ALU_control_ID=(clr_control)?0:ALU_control;
    assign PCsrc_ID=(clr_control)?0:PCsrc;
    assign Jmp_ID=(clr_control)?0:Jmp;
    assign branch_ID=(clr_control)?0:branch;
    assign decide_br_ID=(clr_control)?0:decide_br;

    //end ID________________________________________

   ID_EX Id_Ex(
        .clk(clk),
        .rst(rst),
        .Reg_Write_ID(Reg_Write_ID),
        .memWrite_ID(memWrite_ID),
        .memRead_ID(memRead_ID),
        .RegDst_ID(RegDst_ID),
        .ALUsrc_ID(ALUsrc_ID),
        .memToReg_ID(memToReg_ID),
        .link31_ID(link31_ID),
        .writePC_ID(writePC_ID),
        .ALU_control_ID(ALU_control_ID),
        .Read_Data1_ID(Read_Data1),
        .Read_Data2_ID(Read_Data2),
        .inst_ID(inst_ID),
        .PC_ID(PC_ID),
        .Reg_Write_EX(Reg_Write_EX),
        .memWrite_EX(memWrite_EX),
        .memRead_EX(memRead_EX),
        .RegDst_EX(RegDst_EX),
        .ALUsrc_EX(ALUsrc_EX),
        .memToReg_EX(memToReg_EX),
        .link31_EX(link31_EX),
        .writePC_EX(writePC_EX),
        .ALU_control_EX(ALU_control_EX),
        .Read_Data1_EX(Read_Data1_EX),
        .Read_Data2_EX(Read_Data2_EX),
        .inst_EX(inst_EX),
        .PC_EX(PC_EX),
        .Jmp_ID(Jmp),
        .Jmp_EX(Jmp_EX),
        .PCsrc_ID(PCsrc),
        .PCsrc_EX(PCsrc_EX),
        .branch_ID(branch_ID),
        .branch_EX(branch_EX),
        .decide_br_ID(decide_br_ID),
        .decide_br_EX(decide_br_EX)
   );

    //EX____________________________________________

    ALU alu(
        .A(ALUin1),
        .B(ALUin2),
        .ALU_control(ALU_control_EX),
        .Zero(Zero),
        .Out(ALUout)
    );

    mux2nton #5 dstReg(
        .a(inst_EX[20:16]),
        .b(inst_EX[15:11]),
        .o(outReg),
        .s(RegDst_EX)
    );

    mux2nton #5 reg31(
        .a(outReg),
        .b(5'd31),
        .o(Write_Reg),
        .s(link31_EX)
    );

    mux2nton ALUB(
        .a(NotForwardBin),
        .b({{16{inst_EX[15]}},inst_EX[15:0]}),
        .s(ALUsrc_EX),
        .o(ALUin2)
    );

    mux3nton ForwardAmux(
        .a(Read_Data1_EX),
        .b(ALUout_MEM),
        .c(Write_Data),
        .o(ALUin1),
        .s(ForwardA)
    );

    mux3nton ForwardBmux(
        .a(Read_Data2_EX),
        .b(ALUout_MEM),
        .c(Write_Data),
        .o(NotForwardBin),
        .s(ForwardB)
    );

    //end EX________________________________________

    EX_MEM Ex_Mem(
        .clk(clk),
        .rst(rst),
        .Reg_Write_EX(Reg_Write_EX),
        .memWrite_EX(memWrite_EX),
        .memRead_EX(memRead_EX),
        .memToReg_EX(memToReg_EX),
        .writePC_EX(writePC_EX),
        .Read_Data2_EX(Read_Data2_EX),
        .ALUout_EX(ALUout),
        .Write_Reg_EX(Write_Reg),
        .PC_EX(PC_EX),
        .Reg_Write_MEM(Reg_Write_MEM),
        .memWrite_MEM(memWrite_MEM),
        .memRead_MEM(memRead_MEM),
        .memToReg_MEM(memToReg_MEM),
        .writePC_MEM(writePC_MEM),
        .Read_Data2_MEM(Read_Data2_MEM),
        .ALUout_MEM(ALUout_MEM),
        .Write_Reg_MEM(Write_Reg_MEM),
        .PC_MEM(PC_MEM)
    );

    //MEM___________________________________________

    data_mem dm(
        .memWrite(memWrite_MEM),
        .memRead(memRead_MEM),
        .writeData(Read_Data2_MEM),
        .Address(ALUout_MEM),
        .readData(readDataMem)
    );


    //end_MEM_______________________________________

    MEM_WB Mem_Wb(
        .clk(clk),
        .rst(rst),
        .Reg_Write_MEM(Reg_Write_MEM),
        .memToReg_MEM(memToReg_MEM),
        .writePC_MEM(writePC_MEM),
        .Write_Reg_MEM(Write_Reg_MEM),
        .ALUout_MEM(ALUout_MEM),
        .readDataMem_MEM(readDataMem),
        .PC_MEM(PC_MEM),
        .Reg_Write_WB(Reg_Write_WB),
        .memToReg_WB(memToReg_WB),
        .writePC_WB(writePC_WB),
        .Write_Reg_WB(Write_Reg_WB),
        .ALUout_WB(ALUout_WB),
        .readDataMem_WB(readDataMem_WB),
        .PC_WB(PC_WB)
    );

    //WB____________________________________________

    mux2nton memtoreg(
        .b(readDataMem_WB),
        .a(ALUout_WB),
        .o(memData),
        .s(memToReg_WB)
    );

    mux2nton PCdata(
        .b(PC_WB),
        .a(memData),
        .o(Write_Data),
        .s(writePC_WB)
    );

    //end_WB________________________________________

    //Forwarding
    ForwardingUnit fu(
        .Rs_EX(inst_EX[25:21]),
        .Rt_EX(inst_EX[20:16]),
        .Reg_Write_MEM(Reg_Write_MEM),
        .Reg_Write_WB(Reg_Write_WB),
        .Rd_MEM(Write_Reg_MEM), 
        .Rd_WB(Write_Reg_WB),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

    //HazardUnit

    HazardUnit hu(
        .memRead_EX(memRead_EX),
        .branch_ID(branch),
        .Rs_ID(inst_ID[25:21]),
        .Rt_ID(inst_ID[20:16]),
        .Rt_EX(inst_EX[20:16]),
        .Rd_MEM(Write_Reg_MEM),
        .Rd_EX(Write_Reg),
        .clr_control(clr_control),
        .IF_ID_write(IF_ID_write),
        .PC_write(PC_write)
    );

endmodule