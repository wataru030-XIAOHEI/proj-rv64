`timescale 1ns/1ps

module gtclk_tb();
	logic clkin , clko , clken ;

	logic rst ;

	initial begin 
		rst = 1'b1 ;
		#100;
		rst = 1'b0 ;
	end

	gtclk dut (.clock(clkin) ,.reset(rst),.io_ena(clken),.io_clko(clko));

	initial begin 
		$dumpfile("gtclk_tb.vcd");
		$dumpvars(0,gtclk_tb);
	end

	initial begin
		#90;
		clkin = 1'b0 ;
		wait(rst==0);
		forever #10 clkin = ~clkin ;
	end

	initial begin
	    clken = 0 ;
		#1219;
		clken = 1 ;
		#1000;$finish();
	end

endmodule 
