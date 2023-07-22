`timescale 1ns/1ps
module fifo_tb();

bit clk , rst ;

fifo_if tb_if(clk,rst);

fifo dut(
.clock      (tb_if.clk          ),
.reset      (tb_if.rst          ),
.io_wr_ready(tb_if.io_wr_ready  ),
.io_wr_valid(tb_if.io_wr_valid  ),
.io_wr_bits (tb_if.io_wr_bits   ),
.io_rd_ready(tb_if.io_rd_ready  ),
.io_rd_valid(tb_if.io_rd_valid  ),
.io_rd_bits (tb_if.io_rd_bits   )
);


initial begin 
    clk = 0 ;
    rst = 1 ;
    #100 ;
    rst = 0 ;
end 
always #10 clk = ~clk ;

initial begin 
	$dumpfile("fifo_tb.vcd");
	$dumpvars(0,fifo_tb);
	for(int i = 0 ; i < 16 ; i++)begin
	$dumpvars(0,fifo_tb.dut.ram[i]);
	end
end

initial begin 
    @(negedge rst);
    run();
    $finish();
end 

task run;
    for(int i = 0 ; i < 32 ; i ++) begin
        tb_if.io_wr_valid = $random() % 2 ;
        tb_if.io_wr_bits  = $random() ;
        tb_if.io_rd_ready = $random() % 2 ;
        @(posedge tb_if.clk);
        #2 ;
    end
endtask

endmodule : fifo_tb 