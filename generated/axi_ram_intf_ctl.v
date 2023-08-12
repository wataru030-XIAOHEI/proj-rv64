module Queue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [3:0]  io_enq_bits_arid,
  input  [31:0] io_enq_bits_araddr,
  input  [3:0]  io_enq_bits_arlen,
  input  [1:0]  io_enq_bits_arbusrt,
  input         io_deq_ready,
  output        io_deq_valid,
  output [3:0]  io_deq_bits_arid,
  output [31:0] io_deq_bits_araddr,
  output [3:0]  io_deq_bits_arlen,
  output [1:0]  io_deq_bits_arbusrt
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] ram_arid [0:2]; // @[Decoupled.scala 273:95]
  wire  ram_arid_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_arid_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [3:0] ram_arid_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_arid_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_arid_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_arid_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_arid_MPORT_en; // @[Decoupled.scala 273:95]
  reg [31:0] ram_araddr [0:2]; // @[Decoupled.scala 273:95]
  wire  ram_araddr_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_araddr_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [31:0] ram_araddr_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [31:0] ram_araddr_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_araddr_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_araddr_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_araddr_MPORT_en; // @[Decoupled.scala 273:95]
  reg [3:0] ram_arlen [0:2]; // @[Decoupled.scala 273:95]
  wire  ram_arlen_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_arlen_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [3:0] ram_arlen_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_arlen_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_arlen_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_arlen_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_arlen_MPORT_en; // @[Decoupled.scala 273:95]
  reg [1:0] ram_arbusrt [0:2]; // @[Decoupled.scala 273:95]
  wire  ram_arbusrt_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_arbusrt_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [1:0] ram_arbusrt_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_arbusrt_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_arbusrt_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_arbusrt_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_arbusrt_MPORT_en; // @[Decoupled.scala 273:95]
  reg [1:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [1:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire  wrap = enq_ptr_value == 2'h2; // @[Counter.scala 73:24]
  wire [1:0] _value_T_1 = enq_ptr_value + 2'h1; // @[Counter.scala 77:24]
  wire  wrap_1 = deq_ptr_value == 2'h2; // @[Counter.scala 73:24]
  wire [1:0] _value_T_3 = deq_ptr_value + 2'h1; // @[Counter.scala 77:24]
  assign ram_arid_io_deq_bits_MPORT_en = 1'h1;
  assign ram_arid_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_arid_io_deq_bits_MPORT_data = ram_arid[ram_arid_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_arid_io_deq_bits_MPORT_data = ram_arid_io_deq_bits_MPORT_addr >= 2'h3 ? _RAND_1[3:0] :
    ram_arid[ram_arid_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_arid_MPORT_data = io_enq_bits_arid;
  assign ram_arid_MPORT_addr = enq_ptr_value;
  assign ram_arid_MPORT_mask = 1'h1;
  assign ram_arid_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_araddr_io_deq_bits_MPORT_en = 1'h1;
  assign ram_araddr_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_araddr_io_deq_bits_MPORT_data = ram_araddr[ram_araddr_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_araddr_io_deq_bits_MPORT_data = ram_araddr_io_deq_bits_MPORT_addr >= 2'h3 ? _RAND_3[31:0] :
    ram_araddr[ram_araddr_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_araddr_MPORT_data = io_enq_bits_araddr;
  assign ram_araddr_MPORT_addr = enq_ptr_value;
  assign ram_araddr_MPORT_mask = 1'h1;
  assign ram_araddr_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_arlen_io_deq_bits_MPORT_en = 1'h1;
  assign ram_arlen_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_arlen_io_deq_bits_MPORT_data = ram_arlen[ram_arlen_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_arlen_io_deq_bits_MPORT_data = ram_arlen_io_deq_bits_MPORT_addr >= 2'h3 ? _RAND_5[3:0] :
    ram_arlen[ram_arlen_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_arlen_MPORT_data = io_enq_bits_arlen;
  assign ram_arlen_MPORT_addr = enq_ptr_value;
  assign ram_arlen_MPORT_mask = 1'h1;
  assign ram_arlen_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_arbusrt_io_deq_bits_MPORT_en = 1'h1;
  assign ram_arbusrt_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_arbusrt_io_deq_bits_MPORT_data = ram_arbusrt[ram_arbusrt_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_arbusrt_io_deq_bits_MPORT_data = ram_arbusrt_io_deq_bits_MPORT_addr >= 2'h3 ? _RAND_7[1:0] :
    ram_arbusrt[ram_arbusrt_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_arbusrt_MPORT_data = io_enq_bits_arbusrt;
  assign ram_arbusrt_MPORT_addr = enq_ptr_value;
  assign ram_arbusrt_MPORT_mask = 1'h1;
  assign ram_arbusrt_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 303:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits_arid = ram_arid_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_araddr = ram_araddr_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_arlen = ram_arlen_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_arbusrt = ram_arbusrt_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_arid_MPORT_en & ram_arid_MPORT_mask) begin
      ram_arid[ram_arid_MPORT_addr] <= ram_arid_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_araddr_MPORT_en & ram_araddr_MPORT_mask) begin
      ram_araddr[ram_araddr_MPORT_addr] <= ram_araddr_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_arlen_MPORT_en & ram_arlen_MPORT_mask) begin
      ram_arlen[ram_arlen_MPORT_addr] <= ram_arlen_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_arbusrt_MPORT_en & ram_arbusrt_MPORT_mask) begin
      ram_arbusrt[ram_arbusrt_MPORT_addr] <= ram_arbusrt_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 2'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      if (wrap) begin // @[Counter.scala 87:20]
        enq_ptr_value <= 2'h0; // @[Counter.scala 87:28]
      end else begin
        enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
      end
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 2'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 290:16]
      if (wrap_1) begin // @[Counter.scala 87:20]
        deq_ptr_value <= 2'h0; // @[Counter.scala 87:28]
      end else begin
        deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
      end
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
  _RAND_3 = {1{`RANDOM}};
  _RAND_5 = {1{`RANDOM}};
  _RAND_7 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_arid[initvar] = _RAND_0[3:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_araddr[initvar] = _RAND_2[31:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_arlen[initvar] = _RAND_4[3:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_arbusrt[initvar] = _RAND_6[1:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  enq_ptr_value = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  deq_ptr_value = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  maybe_full = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module axi_fifo(
  input         clock,
  input         reset,
  output        io_wr_ready,
  input         io_wr_valid,
  input  [3:0]  io_wr_bits_arid,
  input  [31:0] io_wr_bits_araddr,
  input  [3:0]  io_wr_bits_arlen,
  input  [1:0]  io_wr_bits_arbusrt,
  input         io_rd_ready,
  output        io_rd_valid,
  output [3:0]  io_rd_bits_arid,
  output [31:0] io_rd_bits_araddr,
  output [3:0]  io_rd_bits_arlen,
  output [1:0]  io_rd_bits_arbusrt
);
  wire  io_rd_q_clock; // @[Decoupled.scala 375:21]
  wire  io_rd_q_reset; // @[Decoupled.scala 375:21]
  wire  io_rd_q_io_enq_ready; // @[Decoupled.scala 375:21]
  wire  io_rd_q_io_enq_valid; // @[Decoupled.scala 375:21]
  wire [3:0] io_rd_q_io_enq_bits_arid; // @[Decoupled.scala 375:21]
  wire [31:0] io_rd_q_io_enq_bits_araddr; // @[Decoupled.scala 375:21]
  wire [3:0] io_rd_q_io_enq_bits_arlen; // @[Decoupled.scala 375:21]
  wire [1:0] io_rd_q_io_enq_bits_arbusrt; // @[Decoupled.scala 375:21]
  wire  io_rd_q_io_deq_ready; // @[Decoupled.scala 375:21]
  wire  io_rd_q_io_deq_valid; // @[Decoupled.scala 375:21]
  wire [3:0] io_rd_q_io_deq_bits_arid; // @[Decoupled.scala 375:21]
  wire [31:0] io_rd_q_io_deq_bits_araddr; // @[Decoupled.scala 375:21]
  wire [3:0] io_rd_q_io_deq_bits_arlen; // @[Decoupled.scala 375:21]
  wire [1:0] io_rd_q_io_deq_bits_arbusrt; // @[Decoupled.scala 375:21]
  Queue io_rd_q ( // @[Decoupled.scala 375:21]
    .clock(io_rd_q_clock),
    .reset(io_rd_q_reset),
    .io_enq_ready(io_rd_q_io_enq_ready),
    .io_enq_valid(io_rd_q_io_enq_valid),
    .io_enq_bits_arid(io_rd_q_io_enq_bits_arid),
    .io_enq_bits_araddr(io_rd_q_io_enq_bits_araddr),
    .io_enq_bits_arlen(io_rd_q_io_enq_bits_arlen),
    .io_enq_bits_arbusrt(io_rd_q_io_enq_bits_arbusrt),
    .io_deq_ready(io_rd_q_io_deq_ready),
    .io_deq_valid(io_rd_q_io_deq_valid),
    .io_deq_bits_arid(io_rd_q_io_deq_bits_arid),
    .io_deq_bits_araddr(io_rd_q_io_deq_bits_araddr),
    .io_deq_bits_arlen(io_rd_q_io_deq_bits_arlen),
    .io_deq_bits_arbusrt(io_rd_q_io_deq_bits_arbusrt)
  );
  assign io_wr_ready = io_rd_q_io_enq_ready; // @[Decoupled.scala 379:17]
  assign io_rd_valid = io_rd_q_io_deq_valid; // @[axi_fifo.scala 14:9]
  assign io_rd_bits_arid = io_rd_q_io_deq_bits_arid; // @[axi_fifo.scala 14:9]
  assign io_rd_bits_araddr = io_rd_q_io_deq_bits_araddr; // @[axi_fifo.scala 14:9]
  assign io_rd_bits_arlen = io_rd_q_io_deq_bits_arlen; // @[axi_fifo.scala 14:9]
  assign io_rd_bits_arbusrt = io_rd_q_io_deq_bits_arbusrt; // @[axi_fifo.scala 14:9]
  assign io_rd_q_clock = clock;
  assign io_rd_q_reset = reset;
  assign io_rd_q_io_enq_valid = io_wr_valid; // @[Decoupled.scala 377:22]
  assign io_rd_q_io_enq_bits_arid = io_wr_bits_arid; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_enq_bits_araddr = io_wr_bits_araddr; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_enq_bits_arlen = io_wr_bits_arlen; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_enq_bits_arbusrt = io_wr_bits_arbusrt; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_deq_ready = io_rd_ready; // @[axi_fifo.scala 14:9]
endmodule
module axi_ram_intf_ctl(
  input         clock,
  input         reset,
  output        io_axi_mst_ar_chl_ready,
  input         io_axi_mst_ar_chl_valid,
  input  [3:0]  io_axi_mst_ar_chl_bits_arid,
  input  [31:0] io_axi_mst_ar_chl_bits_araddr,
  input  [2:0]  io_axi_mst_ar_chl_bits_arsize,
  input  [3:0]  io_axi_mst_ar_chl_bits_arlen,
  input  [1:0]  io_axi_mst_ar_chl_bits_arbusrt,
  input  [1:0]  io_axi_mst_ar_chl_bits_arlock,
  input  [1:0]  io_axi_mst_ar_chl_bits_arcache,
  input  [1:0]  io_axi_mst_ar_chl_bits_arprot,
  input         io_axi_mst_r_chl_ready,
  output        io_axi_mst_r_chl_valid,
  output [31:0] io_axi_mst_r_chl_bits_rdata,
  output [3:0]  io_axi_mst_r_chl_bits_rid,
  output [1:0]  io_axi_mst_r_chl_bits_rresp,
  output        io_axi_mst_r_chl_bits_rlast,
  output        io_axi_mst_aw_chl_ready,
  input         io_axi_mst_aw_chl_valid,
  input  [3:0]  io_axi_mst_aw_chl_bits_awid,
  input  [31:0] io_axi_mst_aw_chl_bits_awaddr,
  input  [2:0]  io_axi_mst_aw_chl_bits_awsize,
  input  [3:0]  io_axi_mst_aw_chl_bits_awlen,
  input  [1:0]  io_axi_mst_aw_chl_bits_awbusrt,
  input  [1:0]  io_axi_mst_aw_chl_bits_awlock,
  input  [1:0]  io_axi_mst_aw_chl_bits_awcache,
  input  [1:0]  io_axi_mst_aw_chl_bits_awprot,
  output        io_axi_mst_w_chl_ready,
  input         io_axi_mst_w_chl_valid,
  input  [31:0] io_axi_mst_w_chl_bits_wdata,
  input  [3:0]  io_axi_mst_w_chl_bits_wid,
  input  [3:0]  io_axi_mst_w_chl_bits_wstrb,
  input         io_axi_mst_w_chl_bits_wlast,
  input         io_axi_mst_b_chl_ready,
  output        io_axi_mst_b_chl_valid,
  output [3:0]  io_axi_mst_b_chl_bits_bid,
  output [1:0]  io_axi_mst_b_chl_bits_bresp,
  output [31:0] io_adr,
  output        io_ren,
  output        io_wen,
  output [3:0]  io_wstrb,
  output [31:0] io_wdat,
  input  [31:0] io_rdat,
  input         io_rvld
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  axi_ar_fifo_clock; // @[axi_ram_ctl.scala 47:27]
  wire  axi_ar_fifo_reset; // @[axi_ram_ctl.scala 47:27]
  wire  axi_ar_fifo_io_wr_ready; // @[axi_ram_ctl.scala 47:27]
  wire  axi_ar_fifo_io_wr_valid; // @[axi_ram_ctl.scala 47:27]
  wire [3:0] axi_ar_fifo_io_wr_bits_arid; // @[axi_ram_ctl.scala 47:27]
  wire [31:0] axi_ar_fifo_io_wr_bits_araddr; // @[axi_ram_ctl.scala 47:27]
  wire [3:0] axi_ar_fifo_io_wr_bits_arlen; // @[axi_ram_ctl.scala 47:27]
  wire [1:0] axi_ar_fifo_io_wr_bits_arbusrt; // @[axi_ram_ctl.scala 47:27]
  wire  axi_ar_fifo_io_rd_ready; // @[axi_ram_ctl.scala 47:27]
  wire  axi_ar_fifo_io_rd_valid; // @[axi_ram_ctl.scala 47:27]
  wire [3:0] axi_ar_fifo_io_rd_bits_arid; // @[axi_ram_ctl.scala 47:27]
  wire [31:0] axi_ar_fifo_io_rd_bits_araddr; // @[axi_ram_ctl.scala 47:27]
  wire [3:0] axi_ar_fifo_io_rd_bits_arlen; // @[axi_ram_ctl.scala 47:27]
  wire [1:0] axi_ar_fifo_io_rd_bits_arbusrt; // @[axi_ram_ctl.scala 47:27]
  wire  arack = io_axi_mst_ar_chl_ready & io_axi_mst_ar_chl_valid; // @[axi_ram_ctl.scala 46:39]
  reg  ar_ready_r; // @[axi_ram_ctl.scala 49:27]
  reg [3:0] rdat_cnt_r; // @[axi_ram_ctl.scala 61:27]
  wire  wrap_mode = axi_ar_fifo_io_rd_bits_arbusrt == 2'h2; // @[axi_ram_ctl.scala 64:54]
  wire  incr_mode = axi_ar_fifo_io_rd_bits_arbusrt == 2'h1; // @[axi_ram_ctl.scala 65:54]
  wire  fixed_mode = axi_ar_fifo_io_rd_bits_arbusrt == 2'h0; // @[axi_ram_ctl.scala 66:54]
  wire  burst_mode = wrap_mode | incr_mode | fixed_mode; // @[axi_ram_ctl.scala 67:42]
  wire [31:0] _GEN_4 = {{28'd0}, rdat_cnt_r}; // @[axi_ram_ctl.scala 71:49]
  wire [31:0] burst_radr = axi_ar_fifo_io_rd_bits_araddr + _GEN_4; // @[axi_ram_ctl.scala 71:49]
  wire  _rack_T = io_axi_mst_r_chl_valid & io_axi_mst_r_chl_ready; // @[axi_ram_ctl.scala 73:38]
  wire  rack = io_axi_mst_r_chl_valid & io_axi_mst_r_chl_ready & io_axi_mst_r_chl_bits_rlast; // @[axi_ram_ctl.scala 73:64]
  wire [3:0] _rdat_cnt_in_T_2 = rdat_cnt_r + 4'h1; // @[axi_ram_ctl.scala 85:34]
  wire [31:0] _io_adr_T = axi_ar_fifo_io_rd_bits_araddr; // @[Mux.scala 101:16]
  wire [31:0] _io_adr_T_1 = burst_mode ? burst_radr : _io_adr_T; // @[Mux.scala 101:16]
  axi_fifo axi_ar_fifo ( // @[axi_ram_ctl.scala 47:27]
    .clock(axi_ar_fifo_clock),
    .reset(axi_ar_fifo_reset),
    .io_wr_ready(axi_ar_fifo_io_wr_ready),
    .io_wr_valid(axi_ar_fifo_io_wr_valid),
    .io_wr_bits_arid(axi_ar_fifo_io_wr_bits_arid),
    .io_wr_bits_araddr(axi_ar_fifo_io_wr_bits_araddr),
    .io_wr_bits_arlen(axi_ar_fifo_io_wr_bits_arlen),
    .io_wr_bits_arbusrt(axi_ar_fifo_io_wr_bits_arbusrt),
    .io_rd_ready(axi_ar_fifo_io_rd_ready),
    .io_rd_valid(axi_ar_fifo_io_rd_valid),
    .io_rd_bits_arid(axi_ar_fifo_io_rd_bits_arid),
    .io_rd_bits_araddr(axi_ar_fifo_io_rd_bits_araddr),
    .io_rd_bits_arlen(axi_ar_fifo_io_rd_bits_arlen),
    .io_rd_bits_arbusrt(axi_ar_fifo_io_rd_bits_arbusrt)
  );
  assign io_axi_mst_ar_chl_ready = ar_ready_r; // @[axi_ram_ctl.scala 56:27]
  assign io_axi_mst_r_chl_valid = io_rvld; // @[axi_ram_ctl.scala 96:31]
  assign io_axi_mst_r_chl_bits_rdata = io_rdat; // @[axi_ram_ctl.scala 99:31]
  assign io_axi_mst_r_chl_bits_rid = axi_ar_fifo_io_rd_bits_arid; // @[axi_ram_ctl.scala 98:31]
  assign io_axi_mst_r_chl_bits_rresp = 2'h0; // @[axi_ram_ctl.scala 75:29]
  assign io_axi_mst_r_chl_bits_rlast = rdat_cnt_r == axi_ar_fifo_io_rd_bits_arlen; // @[axi_ram_ctl.scala 74:26]
  assign io_axi_mst_aw_chl_ready = 1'h0;
  assign io_axi_mst_w_chl_ready = 1'h0;
  assign io_axi_mst_b_chl_valid = 1'h0;
  assign io_axi_mst_b_chl_bits_bid = 4'h0;
  assign io_axi_mst_b_chl_bits_bresp = 2'h0;
  assign io_adr = fixed_mode ? axi_ar_fifo_io_rd_bits_araddr : _io_adr_T_1; // @[Mux.scala 101:16]
  assign io_ren = axi_ar_fifo_io_rd_valid; // @[axi_ram_ctl.scala 95:10]
  assign io_wen = 1'h0;
  assign io_wstrb = 4'h0;
  assign io_wdat = 32'h0;
  assign axi_ar_fifo_clock = clock;
  assign axi_ar_fifo_reset = reset;
  assign axi_ar_fifo_io_wr_valid = io_axi_mst_ar_chl_ready & io_axi_mst_ar_chl_valid; // @[axi_ram_ctl.scala 46:39]
  assign axi_ar_fifo_io_wr_bits_arid = io_axi_mst_ar_chl_bits_arid; // @[axi_ram_ctl.scala 58:27]
  assign axi_ar_fifo_io_wr_bits_araddr = io_axi_mst_ar_chl_bits_araddr; // @[axi_ram_ctl.scala 58:27]
  assign axi_ar_fifo_io_wr_bits_arlen = io_axi_mst_ar_chl_bits_arlen; // @[axi_ram_ctl.scala 58:27]
  assign axi_ar_fifo_io_wr_bits_arbusrt = io_axi_mst_ar_chl_bits_arbusrt; // @[axi_ram_ctl.scala 58:27]
  assign axi_ar_fifo_io_rd_ready = io_axi_mst_r_chl_valid & io_axi_mst_r_chl_ready & io_axi_mst_r_chl_bits_rlast; // @[axi_ram_ctl.scala 73:64]
  always @(posedge clock) begin
    if (reset) begin // @[axi_ram_ctl.scala 49:27]
      ar_ready_r <= 1'h0; // @[axi_ram_ctl.scala 49:27]
    end else if (arack) begin // @[axi_ram_ctl.scala 51:14]
      ar_ready_r <= 1'h0; // @[axi_ram_ctl.scala 52:16]
    end else if (io_axi_mst_ar_chl_valid) begin // @[axi_ram_ctl.scala 53:39]
      ar_ready_r <= axi_ar_fifo_io_wr_ready; // @[axi_ram_ctl.scala 54:16]
    end
    if (reset) begin // @[axi_ram_ctl.scala 61:27]
      rdat_cnt_r <= 4'h0; // @[axi_ram_ctl.scala 61:27]
    end else if (rack) begin // @[axi_ram_ctl.scala 78:13]
      rdat_cnt_r <= 4'h0; // @[axi_ram_ctl.scala 79:16]
    end else if (burst_mode) begin // @[axi_ram_ctl.scala 80:26]
      if (_rack_T) begin // @[axi_ram_ctl.scala 84:21]
        rdat_cnt_r <= _rdat_cnt_in_T_2;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ar_ready_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rdat_cnt_r = _RAND_1[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
