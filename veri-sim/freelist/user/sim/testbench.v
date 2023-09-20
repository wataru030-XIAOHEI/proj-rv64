module testbench();

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 32;
parameter MAIN_FRE   = 100; //unit MHz
reg                   clock = 0;
reg                   reset = 1;
reg [DATA_WIDTH-1:0]  data = 0;
reg [ADDR_WIDTH-1:0]  addr = 0;

always begin
    #(500/MAIN_FRE) clock = ~clock;
end

always begin
    #50 reset = 0;
end

always @(posedge clock) begin
    if (reset) 
        addr = 0;
    else      
        addr = addr + 1;
end
always @(posedge clock) begin
    if (reset) 
        data = 0;
    else      
        data = data + 1;
end

//Instance 
// outports wire
wire [5:0] 	io_pidx_0;
wire [5:0] 	io_pidx_1;
wire [5:0] 	io_pidx_2;
wire [5:0] 	io_pidx_3;
wire       	io_pvld_0;
wire       	io_pvld_1;
wire       	io_pvld_2;
wire       	io_pvld_3;
wire       	io_busy;

reg         io_req_0       ;
reg         io_req_1       ;
reg         io_req_2       ;
reg         io_req_3       ;
reg         io_rls_0       ;
reg         io_rls_1       ;
reg         io_rls_2       ;
reg         io_rls_3       ;
reg  [5:0]  io_rls_pidx_0  ;
reg  [5:0]  io_rls_pidx_1  ;
reg  [5:0]  io_rls_pidx_2  ;
reg  [5:0]  io_rls_pidx_3  ;

initial begin 
	io_req_0 = 0 ; io_req_1 = 0 ; io_req_2 = 0 ; io_req_3 = 0;
	io_rls_0 = 0 ; io_rls_1 = 0 ; io_rls_2 = 0 ; io_rls_3 = 0;
	io_rls_pidx_0 = 0 ; io_rls_pidx_1 = 0 ; io_rls_pidx_2 = 0 ; io_rls_pidx_3 = 0 ;
	@(negedge reset);
	io_req_0 = 1 ;
end


freelist u_freelist(
	.clock         	( clock          ),
	.reset         	( reset          ),
	.io_req_0      	( io_req_0       ),
	.io_req_1      	( io_req_1       ),
	.io_req_2      	( io_req_2       ),
	.io_req_3      	( io_req_3       ),
	.io_pidx_0     	( io_pidx_0      ),
	.io_pidx_1     	( io_pidx_1      ),
	.io_pidx_2     	( io_pidx_2      ),
	.io_pidx_3     	( io_pidx_3      ),
	.io_pvld_0     	( io_pvld_0      ),
	.io_pvld_1     	( io_pvld_1      ),
	.io_pvld_2     	( io_pvld_2      ),
	.io_pvld_3     	( io_pvld_3      ),
	.io_busy       	( io_busy        ),
	.io_rls_0      	( io_rls_0       ),
	.io_rls_1      	( io_rls_1       ),
	.io_rls_2      	( io_rls_2       ),
	.io_rls_3      	( io_rls_3       ),
	.io_rls_pidx_0 	( io_rls_pidx_0  ),
	.io_rls_pidx_1 	( io_rls_pidx_1  ),
	.io_rls_pidx_2 	( io_rls_pidx_2  ),
	.io_rls_pidx_3 	( io_rls_pidx_3  )
);



initial begin            
    $dumpfile("wave.vcd");        
    $dumpvars(0, testbench);    
    #50000 $finish;
end

endmodule  //TOP
