`timescale 1ns/1ps
module ref_mdl(input clock,input reset);
reg [31:0] chk_mem [255:0];


reg [31:0] temp ;
integer i ;
initial begin 
    for(i = 0 ; i < 256 ;i = i +1 ) begin 
        temp = $urandom;
        testbench.dut.mem.mem[i] = { temp[31:8], i[7:0] };
        chk_mem[i] = testbench.dut.mem.mem[i];
        t_check_mem(i);
    end 
    $display("Mem Initial Finish !!!\n");
end


reg [31:0] wr_dat_r[$];
reg [ 7:0] wr_adr_r[$];
reg [31:0] wr_pre ;
reg wen_q[$];
always @(posedge clock) begin 
    if(!testbench.dut.io_cen & !testbench.dut.io_wen) begin 
        wr_dat_r.push_back({(testbench.dut.io_wstrb[3] ? testbench.dut.io_d[31:24] : chk_mem[testbench.dut.io_adr][31:24]),
                            (testbench.dut.io_wstrb[2] ? testbench.dut.io_d[23:16] : chk_mem[testbench.dut.io_adr][23:16]),
                            (testbench.dut.io_wstrb[1] ? testbench.dut.io_d[15: 8] : chk_mem[testbench.dut.io_adr][15: 8]),
                            (testbench.dut.io_wstrb[0] ? testbench.dut.io_d[ 7: 0] : chk_mem[testbench.dut.io_adr][ 7: 0])});
        wr_adr_r.push_back(testbench.dut.io_adr);
        wen_q.push_back(1'b1);
    end
end

always @(posedge clock) begin 
    #0.1;
    if(wen_q[0]) begin 
        chk_mem[wr_adr_r[0]] = wr_dat_r[0];
        t_check_mem(wr_adr_r[0]);
        wen_q.delete(0);
        wr_adr_r.delete(0);
        wr_dat_r.delete(0);
    end
end


reg [7:0] rd_adr_r[$];
reg       rd_r[$];

always @(posedge clock) begin 
    if(!testbench.dut.io_cen & testbench.dut.io_wen) begin 
        rd_adr_r.push_back(testbench.dut.io_adr);
        rd_r.push_back(1'b1);
    end
end

always @(posedge clock) begin 
    #0.1;
    if(rd_r[0])begin
        if(testbench.dut.io_q != chk_mem[rd_adr_r[0]]) begin 
        $display("========= RMEM CHECK ==============");
        $display("     ERROR DUT MEM[%0d] : 0x%0h   ",rd_adr_r[0],testbench.dut.io_q);
        $display("     ERROR REF MEM[%0d] : 0x%0h   ",rd_adr_r[0],chk_mem[rd_adr_r[0]]);
        $display("      @ T = %t",$time);
        $display("==================================");
        repeat(50) @(posedge clock);
        $finish();
        end
        rd_r.delete(0);
        rd_adr_r.delete(0);
    end
end


task t_check_mem(input [7:0] adr);
    if(`DUT_MEM[adr] != chk_mem[adr])begin 
        $display("========= MEM CHECK ==============");
        $display("     ERROR DUT MEM[%0d] : 0x%0h   ",adr,`DUT_MEM[adr]);
        $display("     ERROR REF MEM[%0d] : 0x%0h   ",adr,chk_mem[adr]);
        $display("      @ T = %t",$time);
        $display("==================================");
        repeat(50) @(posedge clock);
        $finish();
    end
endtask


endmodule