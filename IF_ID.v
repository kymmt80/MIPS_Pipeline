module IF_ID(input clk,rst,ld,input[31:0] inst_IF,PC_IF,output reg[31:0]inst_ID,PC_ID);
always@(posedge clk,posedge rst)begin
    if(rst)begin
        inst_ID<=31'd0;
        PC_ID<=31'd0;
    end
    else if(ld) begin
        inst_ID<=inst_IF;
        PC_ID<=PC_IF;
    end
end
endmodule