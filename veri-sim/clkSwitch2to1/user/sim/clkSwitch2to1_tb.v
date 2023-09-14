`timescale 1ns/1ps
module clkSwitch2to1_tb();
    reg [31:0] cnt ;
    reg rst  ;
    reg clk0 ; reg clk1 ;
    reg clk_sel ;

    wire clko ; 

    wire simend ;

clkSwitch2to1 dut(
  .clock        (/* nop */),
  .reset        (rst),
  .io_clkin_0   (clk0),
  .io_clkin_1   (clk1),
  .io_clksel    (clk_sel),
  .io_clko      (clko)
);


always #7 clk0 = ~clk0 ;
always #2.3 clk1 = ~clk1 ;

initial begin 
    rst = 1 ;
    clk1 = 0 ;
    clk0 = 0 ;
    #1000 ;
    rst = 0; 
    $display("Initial Finish !");
end

initial begin 
	$dumpfile("clkSwitch2to1_tb.vcd");
	$dumpvars(0,clkSwitch2to1_tb);
end


always @(posedge clk0) begin 
    if(rst) begin 
        cnt <= 'd0 ;
    end else begin 
        cnt <= cnt + 1'b1 ;
    end 
end 


always @(posedge clk0) begin 
    if(rst) clk_sel <= 'd0 ;
    else    #100 ;clk_sel <= cnt[6] ? 1'b1:  1'b0;
end

assign simend = cnt[9:8] == 2'b11;

always @(posedge simend) begin $display("simulation finish !!!"); $finish(); end




always @(*) begin : x_z_chk
    if(rst) begin end 
    else begin 
        if($isunknown(clk_sel) == 1) begin $display("clk sel is X or Z !!!"); $finish; end
        if($isunknown(clko) == 1 )   begin $display("clko is X or Z !!!"); $finish; end
    end
end

endmodule //clkSwitch2to1_tb
