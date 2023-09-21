module axi_ram_intf_ctl_tb();
  reg           clock;
  reg           reset;
  wire          io_axi_mst_ar_chl_ready;
  reg           io_axi_mst_ar_chl_valid;
  reg    [3:0]  io_axi_mst_ar_chl_bits_arid;
  reg    [31:0] io_axi_mst_ar_chl_bits_araddr;
  reg    [2:0]  io_axi_mst_ar_chl_bits_arsize;
  reg    [3:0]  io_axi_mst_ar_chl_bits_arlen;
  reg    [1:0]  io_axi_mst_ar_chl_bits_arbusrt;
  reg    [1:0]  io_axi_mst_ar_chl_bits_arlock;
  reg    [1:0]  io_axi_mst_ar_chl_bits_arcache;
  reg    [1:0]  io_axi_mst_ar_chl_bits_arprot;

  reg           io_axi_mst_r_chl_ready;
  wire          io_axi_mst_r_chl_valid;
  wire   [31:0] io_axi_mst_r_chl_bits_rdata;
  wire   [3:0]  io_axi_mst_r_chl_bits_rid;
  wire   [1:0]  io_axi_mst_r_chl_bits_rresp;
  wire          io_axi_mst_r_chl_bits_rlast;

  wire          io_axi_mst_aw_chl_ready       ;
  reg           io_axi_mst_aw_chl_valid       ;
  reg    [3:0]  io_axi_mst_aw_chl_bits_awid   ;
  reg    [31:0] io_axi_mst_aw_chl_bits_awaddr ;
  reg    [2:0]  io_axi_mst_aw_chl_bits_awsize ;
  reg    [3:0]  io_axi_mst_aw_chl_bits_awlen  ;
  reg    [1:0]  io_axi_mst_aw_chl_bits_awbusrt;
  reg    [1:0]  io_axi_mst_aw_chl_bits_awlock ;
  reg    [1:0]  io_axi_mst_aw_chl_bits_awcache;
  reg    [1:0]  io_axi_mst_aw_chl_bits_awprot ;
  wire          io_axi_mst_w_chl_ready        ;
  reg           io_axi_mst_w_chl_valid        ;
  reg    [31:0] io_axi_mst_w_chl_bits_wdata   ;
  reg    [3:0]  io_axi_mst_w_chl_bits_wid     ;
  reg    [3:0]  io_axi_mst_w_chl_bits_wstrb   ;
  reg           io_axi_mst_w_chl_bits_wlast   ;
  reg           io_axi_mst_b_chl_ready        ;
  wire          io_axi_mst_b_chl_valid        ;
  wire   [3:0]  io_axi_mst_b_chl_bits_bid     ;
  wire   [1:0]  io_axi_mst_b_chl_bits_bresp   ;


  wire   [31:0] io_adr  ;
  wire          io_ren  ;
  wire          io_wen  ;
  wire   [3:0]  io_wstrb;
  wire   [31:0] io_wdat ;
  reg    [31:0] io_rdat ;
  reg           io_rvld ;
  reg           io_free ;

axi_ram_intf_ctl dut(
    .clock                          ( clock                          ),
    .reset                          ( reset                          ),
    .io_axi_mst_ar_chl_ready        ( io_axi_mst_ar_chl_ready        ),
    .io_axi_mst_ar_chl_valid        ( io_axi_mst_ar_chl_valid        ),
    .io_axi_mst_ar_chl_bits_arid    ( io_axi_mst_ar_chl_bits_arid    ),
    .io_axi_mst_ar_chl_bits_araddr  ( io_axi_mst_ar_chl_bits_araddr  ),
    .io_axi_mst_ar_chl_bits_arsize  ( io_axi_mst_ar_chl_bits_arsize  ),
    .io_axi_mst_ar_chl_bits_arlen   ( io_axi_mst_ar_chl_bits_arlen   ),
    .io_axi_mst_ar_chl_bits_arbusrt ( io_axi_mst_ar_chl_bits_arbusrt ),
    .io_axi_mst_ar_chl_bits_arlock  ( io_axi_mst_ar_chl_bits_arlock  ),
    .io_axi_mst_ar_chl_bits_arcache ( io_axi_mst_ar_chl_bits_arcache ),
    .io_axi_mst_ar_chl_bits_arprot  ( io_axi_mst_ar_chl_bits_arprot  ),
    .io_axi_mst_r_chl_ready         ( io_axi_mst_r_chl_ready         ),
    .io_axi_mst_r_chl_valid         ( io_axi_mst_r_chl_valid         ),
    .io_axi_mst_r_chl_bits_rdata    ( io_axi_mst_r_chl_bits_rdata    ),
    .io_axi_mst_r_chl_bits_rid      ( io_axi_mst_r_chl_bits_rid      ),
    .io_axi_mst_r_chl_bits_rresp    ( io_axi_mst_r_chl_bits_rresp    ),
    .io_axi_mst_r_chl_bits_rlast    ( io_axi_mst_r_chl_bits_rlast    ),
    .io_axi_mst_aw_chl_ready        ( io_axi_mst_aw_chl_ready        ),
    .io_axi_mst_aw_chl_valid        ( io_axi_mst_aw_chl_valid        ),
    .io_axi_mst_aw_chl_bits_awid    ( io_axi_mst_aw_chl_bits_awid    ),
    .io_axi_mst_aw_chl_bits_awaddr  ( io_axi_mst_aw_chl_bits_awaddr  ),
    .io_axi_mst_aw_chl_bits_awsize  ( io_axi_mst_aw_chl_bits_awsize  ),
    .io_axi_mst_aw_chl_bits_awlen   ( io_axi_mst_aw_chl_bits_awlen   ),
    .io_axi_mst_aw_chl_bits_awbusrt ( io_axi_mst_aw_chl_bits_awbusrt ),
    .io_axi_mst_aw_chl_bits_awlock  ( io_axi_mst_aw_chl_bits_awlock  ),
    .io_axi_mst_aw_chl_bits_awcache ( io_axi_mst_aw_chl_bits_awcache ),
    .io_axi_mst_aw_chl_bits_awprot  ( io_axi_mst_aw_chl_bits_awprot  ),
    .io_axi_mst_w_chl_ready         ( io_axi_mst_w_chl_ready         ),
    .io_axi_mst_w_chl_valid         ( io_axi_mst_w_chl_valid         ),
    .io_axi_mst_w_chl_bits_wdata    ( io_axi_mst_w_chl_bits_wdata    ),
    .io_axi_mst_w_chl_bits_wid      ( io_axi_mst_w_chl_bits_wid      ),
    .io_axi_mst_w_chl_bits_wstrb    ( io_axi_mst_w_chl_bits_wstrb    ),
    .io_axi_mst_w_chl_bits_wlast    ( io_axi_mst_w_chl_bits_wlast    ),
    .io_axi_mst_b_chl_ready         ( io_axi_mst_b_chl_ready         ),
    .io_axi_mst_b_chl_valid         ( io_axi_mst_b_chl_valid         ),
    .io_axi_mst_b_chl_bits_bid      ( io_axi_mst_b_chl_bits_bid      ),
    .io_axi_mst_b_chl_bits_bresp    ( io_axi_mst_b_chl_bits_bresp    ),
    .io_adr                         ( io_adr                         ),
    .io_ren                         ( io_ren                         ),
    .io_wen                         ( io_wen                         ),
    .io_wstrb                       ( io_wstrb                       ),
    .io_wdat                        ( io_wdat                        ),
    .io_rdat                        ( io_rdat                        ),
    .io_rvld                        ( io_rvld                        ),
    .io_free                        ( io_free                        )
);

	initial begin
		#30;
		io_axi_mst_ar_chl_valid			 = 0 ;
		io_axi_mst_ar_chl_bits_arid		 = 0 ;
		io_axi_mst_ar_chl_bits_araddr	 = 0 ;
		io_axi_mst_ar_chl_bits_arsize	 = 0 ;
		io_axi_mst_ar_chl_bits_arlen	 = 0 ;	
		io_axi_mst_ar_chl_bits_arbusrt   = 0 ;
		io_axi_mst_ar_chl_bits_arlock	 = 0 ;
		io_axi_mst_ar_chl_bits_arcache   = 0 ;
		io_axi_mst_ar_chl_bits_arprot	 = 0 ;
		io_axi_mst_r_chl_ready			 = 1 ;

        io_axi_mst_aw_chl_valid          = 0 ;
        io_axi_mst_aw_chl_bits_awid      = 0 ;
        io_axi_mst_aw_chl_bits_awaddr    = 0 ;
        io_axi_mst_aw_chl_bits_awsize    = 0 ;
        io_axi_mst_aw_chl_bits_awlen     = 0 ;
        io_axi_mst_aw_chl_bits_awbusrt   = 0 ;
        io_axi_mst_aw_chl_bits_awlock    = 0 ;
        io_axi_mst_aw_chl_bits_awcache   = 0 ;
        io_axi_mst_aw_chl_bits_awprot    = 0 ;
        io_axi_mst_w_chl_valid           = 0 ;
        io_axi_mst_w_chl_bits_wdata      = 0 ;
        io_axi_mst_w_chl_bits_wid        = 0 ;
        io_axi_mst_w_chl_bits_wstrb      = 0 ;
        io_axi_mst_w_chl_bits_wlast      = 0 ;
        io_axi_mst_b_chl_ready           = 1 ;

		io_rdat							 = 0 ;
		io_rvld							 = 0 ;
end

	initial begin 
		wait(!reset) ;
		@(posedge clock);
		#1 ;
		axi_ar_drv ;
		#300 ;
		axi_aw_drv;
		#50 ;
		$finish;
	end


	task axi_ar_drv;
		io_axi_mst_ar_chl_valid = 1'b1 ;
		io_axi_mst_ar_chl_bits_arid = 4'b0011;
		io_axi_mst_ar_chl_bits_araddr = $urandom ;
		io_axi_mst_ar_chl_bits_arsize = 2 ;
		io_axi_mst_ar_chl_bits_arlen  = 4'h9 ;
		io_axi_mst_ar_chl_bits_arbusrt = 2'b01 ;
		io_axi_mst_ar_chl_bits_arlock = '0 ;
		io_axi_mst_ar_chl_bits_arcache = '0 ;
		io_axi_mst_ar_chl_bits_arprot  = '0 ;
		wait(io_axi_mst_ar_chl_ready && io_axi_mst_ar_chl_valid);
		@(posedge clock);
		#1 ;
		io_axi_mst_ar_chl_valid = 1'b0 ;
		io_axi_mst_ar_chl_bits_arid = 4'b0000;
		io_axi_mst_ar_chl_bits_araddr = 0 ;
		io_axi_mst_ar_chl_bits_arsize = 0 ;
		io_axi_mst_ar_chl_bits_arlen  = 0 ;
		io_axi_mst_ar_chl_bits_arbusrt = 0 ;
		io_axi_mst_ar_chl_bits_arlock = '0 ;
		io_axi_mst_ar_chl_bits_arcache = '0 ;
		io_axi_mst_ar_chl_bits_arprot  = '0 ;
		@(posedge clock);
	endtask
	
	always @(posedge clock ) begin
		if(io_ren)begin
				io_rdat <= io_adr ;
				io_rvld <= 1'b1 ;
		end else begin 
				io_rdat <= '0 ;
				io_rvld <= 1'b0 ;
		end
	end

	task axi_aw_drv;
		io_axi_mst_aw_chl_valid       = 1'b1;
		io_axi_mst_aw_chl_bits_awid   = 4'b0011;
		io_axi_mst_aw_chl_bits_awaddr = $urandom;
		io_axi_mst_aw_chl_bits_awsize = 2;
		io_axi_mst_aw_chl_bits_awlen  = 0;
		io_axi_mst_aw_chl_bits_awbusrt= 0;
		io_axi_mst_aw_chl_bits_awlock = 0;
		io_axi_mst_aw_chl_bits_awcache= 0;
		io_axi_mst_aw_chl_bits_awprot = 0;
		io_axi_mst_w_chl_valid        = 0;
		io_axi_mst_w_chl_bits_wdata   = 0;
		io_axi_mst_w_chl_bits_wid     = 0;
		io_axi_mst_w_chl_bits_wstrb   = 0;
		io_axi_mst_w_chl_bits_wlast   = 0;
		wait(io_axi_mst_aw_chl_ready && io_axi_mst_aw_chl_valid);
		@(posedge clock);
		#1 ;
		io_axi_mst_aw_chl_valid       = 0;
		io_axi_mst_aw_chl_bits_awid   = 0;
		io_axi_mst_aw_chl_bits_awaddr = 0;
		io_axi_mst_aw_chl_bits_awsize = 0;
		io_axi_mst_aw_chl_bits_awlen  = 0;
		io_axi_mst_aw_chl_bits_awbusrt= 0;
		io_axi_mst_aw_chl_bits_awlock = 0;
		io_axi_mst_aw_chl_bits_awcache= 0;
		io_axi_mst_aw_chl_bits_awprot = 0;
		io_axi_mst_w_chl_valid        = 1'b1;
		io_axi_mst_w_chl_bits_wdata   = 32'd3;
		io_axi_mst_w_chl_bits_wid     = 4'b0011;
		io_axi_mst_w_chl_bits_wstrb   = 4'b1111;
		io_axi_mst_w_chl_bits_wlast   = 1;
		wait(io_axi_mst_w_chl_ready && io_axi_mst_w_chl_valid);
		@(posedge clock);
		#1 ;
		io_axi_mst_aw_chl_valid       = 0;
		io_axi_mst_aw_chl_bits_awid   = 0;
		io_axi_mst_aw_chl_bits_awaddr = 0;
		io_axi_mst_aw_chl_bits_awsize = 0;
		io_axi_mst_aw_chl_bits_awlen  = 0;
		io_axi_mst_aw_chl_bits_awbusrt= 0;
		io_axi_mst_aw_chl_bits_awlock = 0;
		io_axi_mst_aw_chl_bits_awcache= 0;
		io_axi_mst_aw_chl_bits_awprot = 0;
		io_axi_mst_w_chl_valid        = 0;
		io_axi_mst_w_chl_bits_wdata   = 0;
		io_axi_mst_w_chl_bits_wid     = 0;
		io_axi_mst_w_chl_bits_wstrb   = 0;
		io_axi_mst_w_chl_bits_wlast   = 0;
	endtask
	
	always @(posedge clock ) begin
		if(io_wen)begin
				io_free <= 1'b1 ;
		end else begin 
				io_free <= 1'b0 ;
		end
	end



	//=======================================================
	//
	// intial clk reset 
	// dump wave 
	// 
	//========================================================
	initial begin 
		clock = 0 ;
		forever #10 clock = ~clock ;
	end 

	initial begin
		reset = 1'b1; 
		#100;
		reset = 1'b0 ;
	end

	initial begin 
		$dumpfile("axi_ram_intf_ctl_tb.vcd");
		$dumpvars(0,axi_ram_intf_ctl_tb);
	end
endmodule
