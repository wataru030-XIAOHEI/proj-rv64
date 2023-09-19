`timescale 1ns/1ps
`include "tb_define.v"
module testbench();

reg                   clock = 0;
reg                   reset = 0;
wire                  simend ;
reg [15:0]            cnt = 0 ;

assign simend = cnt == {16{1'b1}};
always @(posedge clock) begin 
    if(reset) begin 
        cnt <= 0;
    end else begin 
        cnt <= cnt + 1'b1;
    end
end

always begin
    #(10) clock = ~clock;
end

always begin
    #500 reset = 0;
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

ref_mdl ref_mdl(
    .clock 	( clock  )
);



initial begin            
    $dumpfile("wave.vcd");        
    $dumpvars(0, testbench);    
end


always @(posedge simend) begin 
    $display("Finish This Sim !!!");
    $finish;
end

endmodule  //TOP
