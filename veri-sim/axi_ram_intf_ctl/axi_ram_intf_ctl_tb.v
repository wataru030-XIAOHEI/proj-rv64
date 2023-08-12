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

  wire   [31:0] io_adr;
  wire          io_ren;
  reg    [31:0] io_rdat;
  reg           io_rvld;

	axi_ram_intf_ctl dut(
  .clock													(clock													),
  .reset													(reset													),
  .io_axi_mst_ar_chl_ready				(io_axi_mst_ar_chl_ready				),
  .io_axi_mst_ar_chl_valid				(io_axi_mst_ar_chl_valid				),
  .io_axi_mst_ar_chl_bits_arid		(io_axi_mst_ar_chl_bits_arid		),
  .io_axi_mst_ar_chl_bits_araddr	(io_axi_mst_ar_chl_bits_araddr	),
  .io_axi_mst_ar_chl_bits_arsize	(io_axi_mst_ar_chl_bits_arsize	),
  .io_axi_mst_ar_chl_bits_arlen		(io_axi_mst_ar_chl_bits_arlen		),
  .io_axi_mst_ar_chl_bits_arbusrt	(io_axi_mst_ar_chl_bits_arbusrt	),
  .io_axi_mst_ar_chl_bits_arlock	(io_axi_mst_ar_chl_bits_arlock	),
  .io_axi_mst_ar_chl_bits_arcache	(io_axi_mst_ar_chl_bits_arcache	),
  .io_axi_mst_ar_chl_bits_arprot	(io_axi_mst_ar_chl_bits_arprot	),
  .io_axi_mst_r_chl_ready					(io_axi_mst_r_chl_ready					),
  .io_axi_mst_r_chl_valid					(io_axi_mst_r_chl_valid					),
  .io_axi_mst_r_chl_bits_rdata		(io_axi_mst_r_chl_bits_rdata		),
  .io_axi_mst_r_chl_bits_rid			(io_axi_mst_r_chl_bits_rid			),
  .io_axi_mst_r_chl_bits_rresp		(io_axi_mst_r_chl_bits_rresp		),
  .io_axi_mst_r_chl_bits_rlast		(io_axi_mst_r_chl_bits_rlast		),
  .io_adr													(io_adr													),
  .io_ren													(io_ren													),
  .io_rdat												(io_rdat												),
  .io_rvld												(io_rvld												)
	
	);
	initial begin
		#30;
		io_axi_mst_ar_chl_valid				 = 0 ;
		io_axi_mst_ar_chl_bits_arid		 = 0 ;
		io_axi_mst_ar_chl_bits_araddr	 = 0 ;
		io_axi_mst_ar_chl_bits_arsize	 = 0 ;
		io_axi_mst_ar_chl_bits_arlen	 = 0 ;	
		io_axi_mst_ar_chl_bits_arbusrt = 0 ;
		io_axi_mst_ar_chl_bits_arlock	 = 0 ;
		io_axi_mst_ar_chl_bits_arcache = 0 ;
		io_axi_mst_ar_chl_bits_arprot	 = 0 ;
		io_axi_mst_r_chl_ready				 = 1 ;
		io_rdat												 = 0 ;
		io_rvld												 = 0 ;
end

	initial begin 
		wait(!reset) ;
		@(posedge clock);
		#1 ;
		axi_ar_drv ;
		#100 ;
	end


	task axi_ar_drv;
		io_axi_mst_ar_chl_valid = 1'b1 ;
		io_axi_mst_ar_chl_bits_arid = 4'b0011;
		io_axi_mst_ar_chl_bits_araddr = $urandom ;
		io_axi_mst_ar_chl_bits_arsize = 2 ;
		io_axi_mst_ar_chl_bits_arlen  = 'ha ;
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
