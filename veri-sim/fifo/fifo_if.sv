interface fifo_if(input bit clk ,input bit rst );

    logic        io_wr_ready    ;
    logic        io_wr_valid    ;
    logic [31:0] io_wr_bits     ;
    logic        io_rd_ready    ;
    logic        io_rd_valid    ;
    logic [31:0] io_rd_bits     ;

  

endinterface //fifo_if