module golden_mdl (input clk,input rst);
    parameter DP = 256 ;


    reg [31:0] mem [DP-1:0];

  //wire [ 7:0]  adr = testbench.io_adr;
  //wire [31:0]    d = testbench.io_adr;
  //wire [31:0]    q = testbench.io_adr;
  //wire         cen = testbench.io_adr;
  //wire         wen = testbench.io_wen;
  //wire [4:0] wstrb = testbench.io_adr;



  //reg [ 7:0]  adr_r = testbench.io_adr;
  //reg [31:0]    d_r = testbench.io_adr;
  //reg [31:0]    q_r = testbench.io_adr;
  //reg         cen_r = testbench.io_adr;
  //reg         wen_r = testbench.io_wen;
  //reg [4:0] wstrb_r = testbench.io_adr;


  //wire debug_dut_data = `DUT_MEM[30];
  //wire debug_mdl_data = mem[30];

endmodule //golden_mdl
