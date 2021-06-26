module HazardUnit(input memRead_EX,branch_ID,Jumpinp_ID,input[4:0]Rs_ID,Rt_ID,Rt_EX,Rd_EX,Rd_MEM,output reg clr_control,IF_ID_write,PC_write);

always@(*)begin
    clr_control=0;IF_ID_write=1;PC_write=1;
    if(memRead_EX & (Rs_ID==Rt_EX|Rt_ID==Rt_EX))begin
        clr_control=1;IF_ID_write=0;PC_write=0;
    end
    if(branch_ID & ((Rs_ID==Rd_EX&Rs_ID!=0)|(Rt_ID==Rd_MEM&Rt_ID!=0)|(Rt_ID==Rd_EX&Rt_ID!=0)|(Rs_ID==Rd_MEM&Rs_ID!=0)))begin
        clr_control=1;IF_ID_write=0;PC_write=0;
    end
    /*
    if(Jumpinp_ID & ((Rs_ID==Rd_EX&Rs_ID!=0)|(Rs_ID==Rd_MEM&Rs_ID!=0)))begin
        clr_control=1;IF_ID_write=0;PC_write=0;
    end
    */
end

endmodule