module ControlHazard (input clk,t1,t2,t3,output reg flush);
always @(clk) begin
    #1
    if(clk)
        flush=t1|t2|t3;
    else
        flush=0;
end
    
endmodule