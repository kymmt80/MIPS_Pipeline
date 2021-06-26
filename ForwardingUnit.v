module ForwardingUnit(input [4:0] Rs_EX, Rt_EX, input Reg_Write_MEM, Reg_Write_WB, input [4:0] Rd_MEM, Rd_WB, output reg [1:0]ForwardA, ForwardB);

always@(*) begin
    ForwardA=0;ForwardB=0;
    if(Reg_Write_WB&(Rd_WB!=5'd0)) begin
        if(Rs_EX == Rd_WB)
            ForwardA <= 2'd2;
        if(Rt_EX == Rd_WB)
            ForwardB <= 2'd2;
    end
    if(Reg_Write_MEM &( Rs_EX == Rd_MEM | Rt_EX == Rd_MEM)&Rd_MEM!=5'd0 )begin
//ForwardA <= 0;
//ForwardB <= 0;
        if(Rs_EX == Rd_MEM)
            ForwardA <= 2'd1;
        if(Rt_EX == Rd_MEM)
            ForwardB <= 2'd1;
    end
end

endmodule