`timescale 1ns/1ps
`include "tb_define.v"
module testbench();

reg                   clock = 0;
reg                   reset = 0;

always begin
    #(10) clock = ~clock;
end

always begin
    #500 reset = 1;
end

//Instance 
// outports wire
wire [31:0] 	io_q;
reg  [7:0]      io_adr ;
reg             io_cen ;
reg             io_wen ;
reg  [3:0]      io_wstrb;
reg  [31:0]     io_d;

sram_model dut(
    .clock    	( clock     ),
    .reset    	( reset     ),
    .io_adr   	( io_adr    ),
    .io_cen   	( io_cen    ),
    .io_wen   	( io_wen    ),
    .io_wstrb 	( io_wstrb  ),
    .io_d     	( io_d      ),
    .io_q     	( io_q      )
);

golden_mdl mdl(
	.clk 	( clock ),
	.rst 	( reset )
);
reg [31:0] mem[255:0];
integer i;
initial begin
    for(i = 0 ;i < 256 ;i = i+ 1) begin 
        `MDL_MEM[i] = `DUT_MEM[i];
    end
    foreach(mem[i])  `DUT_MEM[i] = i;
end

always @(posedge clock) begin 
    if(reset)begin 
        io_adr   <= 'd0;
        io_cen   <= 'd0;
        io_wen   <= 'd0;
        io_wstrb <= 'd0;
        io_d     <= 'd0;
    end else begin 
        io_adr   <= $urandom;
        io_cen   <= $urandom;
        io_wen   <= $urandom;
        io_wstrb <= $urandom;
        io_d     <= $urandom;
    end
end

initial begin            
    $dumpfile("wave.vcd");        
    $dumpvars(0, testbench);    
    #50000 $finish;
end

endmodule  //TOP
