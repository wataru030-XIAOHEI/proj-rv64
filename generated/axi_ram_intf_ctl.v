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
  assign io_rd_valid = io_rd_q_io_deq_valid; // @[axi_fifo.scala 15:9]
  assign io_rd_bits_arid = io_rd_q_io_deq_bits_arid; // @[axi_fifo.scala 15:9]
  assign io_rd_bits_araddr = io_rd_q_io_deq_bits_araddr; // @[axi_fifo.scala 15:9]
  assign io_rd_bits_arlen = io_rd_q_io_deq_bits_arlen; // @[axi_fifo.scala 15:9]
  assign io_rd_bits_arbusrt = io_rd_q_io_deq_bits_arbusrt; // @[axi_fifo.scala 15:9]
  assign io_rd_q_clock = clock;
  assign io_rd_q_reset = reset;
  assign io_rd_q_io_enq_valid = io_wr_valid; // @[Decoupled.scala 377:22]
  assign io_rd_q_io_enq_bits_arid = io_wr_bits_arid; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_enq_bits_araddr = io_wr_bits_araddr; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_enq_bits_arlen = io_wr_bits_arlen; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_enq_bits_arbusrt = io_wr_bits_arbusrt; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_deq_ready = io_rd_ready; // @[axi_fifo.scala 15:9]
endmodule
module axi_r_ctl(
  input         clock,
  input         reset,
  output        io_axi_ar_ready,
  input         io_axi_ar_valid,
  input  [3:0]  io_axi_ar_bits_arid,
  input  [31:0] io_axi_ar_bits_araddr,
  input  [3:0]  io_axi_ar_bits_arlen,
  input  [1:0]  io_axi_ar_bits_arbusrt,
  input         io_axi_r_ready,
  output        io_axi_r_valid,
  output [31:0] io_axi_r_bits_rdata,
  output [3:0]  io_axi_r_bits_rid,
  output        io_axi_r_bits_rlast,
  output [31:0] io_adr,
  output        io_ren,
  input  [31:0] io_rdat,
  input         io_rvld
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  axi_ar_fifo_clock; // @[axi_r_ctl.scala 33:27]
  wire  axi_ar_fifo_reset; // @[axi_r_ctl.scala 33:27]
  wire  axi_ar_fifo_io_wr_ready; // @[axi_r_ctl.scala 33:27]
  wire  axi_ar_fifo_io_wr_valid; // @[axi_r_ctl.scala 33:27]
  wire [3:0] axi_ar_fifo_io_wr_bits_arid; // @[axi_r_ctl.scala 33:27]
  wire [31:0] axi_ar_fifo_io_wr_bits_araddr; // @[axi_r_ctl.scala 33:27]
  wire [3:0] axi_ar_fifo_io_wr_bits_arlen; // @[axi_r_ctl.scala 33:27]
  wire [1:0] axi_ar_fifo_io_wr_bits_arbusrt; // @[axi_r_ctl.scala 33:27]
  wire  axi_ar_fifo_io_rd_ready; // @[axi_r_ctl.scala 33:27]
  wire  axi_ar_fifo_io_rd_valid; // @[axi_r_ctl.scala 33:27]
  wire [3:0] axi_ar_fifo_io_rd_bits_arid; // @[axi_r_ctl.scala 33:27]
  wire [31:0] axi_ar_fifo_io_rd_bits_araddr; // @[axi_r_ctl.scala 33:27]
  wire [3:0] axi_ar_fifo_io_rd_bits_arlen; // @[axi_r_ctl.scala 33:27]
  wire [1:0] axi_ar_fifo_io_rd_bits_arbusrt; // @[axi_r_ctl.scala 33:27]
  wire  arack = io_axi_ar_valid & io_axi_ar_ready; // @[axi_r_ctl.scala 32:31]
  reg  ar_ready_r; // @[axi_r_ctl.scala 34:27]
  reg [3:0] rdat_cnt_r; // @[axi_r_ctl.scala 48:27]
  wire  wrap_mode = axi_ar_fifo_io_rd_bits_arbusrt == 2'h2; // @[axi_r_ctl.scala 51:50]
  wire  incr_mode = axi_ar_fifo_io_rd_bits_arbusrt == 2'h1; // @[axi_r_ctl.scala 52:50]
  wire  fixed_mode = axi_ar_fifo_io_rd_bits_arbusrt == 2'h0; // @[axi_r_ctl.scala 53:51]
  wire  burst_start = wrap_mode | incr_mode | fixed_mode; // @[axi_r_ctl.scala 54:43]
  wire [31:0] _GEN_4 = {{28'd0}, rdat_cnt_r}; // @[axi_r_ctl.scala 59:49]
  wire [31:0] burst_adr = axi_ar_fifo_io_rd_bits_araddr + _GEN_4; // @[axi_r_ctl.scala 59:49]
  wire  _rack_T = io_axi_r_valid & io_axi_r_ready; // @[axi_r_ctl.scala 61:29]
  wire  rack = io_axi_r_valid & io_axi_r_ready & io_axi_r_bits_rlast; // @[axi_r_ctl.scala 61:47]
  wire  rlast = rdat_cnt_r == axi_ar_fifo_io_rd_bits_arlen; // @[axi_r_ctl.scala 62:26]
  wire [3:0] _rdat_cnt_in_T_2 = rdat_cnt_r + 4'h1; // @[axi_r_ctl.scala 73:32]
  wire [31:0] _io_adr_T = axi_ar_fifo_io_rd_bits_araddr; // @[Mux.scala 101:16]
  wire [31:0] _io_adr_T_1 = incr_mode ? burst_adr : _io_adr_T; // @[Mux.scala 101:16]
  axi_fifo axi_ar_fifo ( // @[axi_r_ctl.scala 33:27]
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
  assign io_axi_ar_ready = ar_ready_r; // @[axi_r_ctl.scala 42:19]
  assign io_axi_r_valid = io_rvld; // @[axi_r_ctl.scala 83:18]
  assign io_axi_r_bits_rdata = io_axi_r_valid ? io_rdat : 32'h0; // @[axi_r_ctl.scala 86:29]
  assign io_axi_r_bits_rid = io_axi_r_valid ? axi_ar_fifo_io_rd_bits_arid : 4'h0; // @[axi_r_ctl.scala 85:29]
  assign io_axi_r_bits_rlast = io_axi_r_valid & rlast; // @[axi_r_ctl.scala 84:29]
  assign io_adr = fixed_mode ? axi_ar_fifo_io_rd_bits_araddr : _io_adr_T_1; // @[Mux.scala 101:16]
  assign io_ren = axi_ar_fifo_io_rd_valid; // @[axi_r_ctl.scala 82:10]
  assign axi_ar_fifo_clock = clock;
  assign axi_ar_fifo_reset = reset;
  assign axi_ar_fifo_io_wr_valid = io_axi_ar_valid & io_axi_ar_ready; // @[axi_r_ctl.scala 32:31]
  assign axi_ar_fifo_io_wr_bits_arid = io_axi_ar_bits_arid; // @[axi_r_ctl.scala 45:27]
  assign axi_ar_fifo_io_wr_bits_araddr = io_axi_ar_bits_araddr; // @[axi_r_ctl.scala 45:27]
  assign axi_ar_fifo_io_wr_bits_arlen = io_axi_ar_bits_arlen; // @[axi_r_ctl.scala 45:27]
  assign axi_ar_fifo_io_wr_bits_arbusrt = io_axi_ar_bits_arbusrt; // @[axi_r_ctl.scala 45:27]
  assign axi_ar_fifo_io_rd_ready = io_axi_r_valid & io_axi_r_ready & io_axi_r_bits_rlast; // @[axi_r_ctl.scala 61:47]
  always @(posedge clock) begin
    if (reset) begin // @[axi_r_ctl.scala 34:27]
      ar_ready_r <= 1'h0; // @[axi_r_ctl.scala 34:27]
    end else if (arack) begin // @[axi_r_ctl.scala 37:14]
      ar_ready_r <= 1'h0; // @[axi_r_ctl.scala 38:16]
    end else if (io_axi_ar_valid) begin // @[axi_r_ctl.scala 39:30]
      ar_ready_r <= axi_ar_fifo_io_wr_ready; // @[axi_r_ctl.scala 40:16]
    end
    if (reset) begin // @[axi_r_ctl.scala 48:27]
      rdat_cnt_r <= 4'h0; // @[axi_r_ctl.scala 48:27]
    end else if (rack) begin // @[axi_r_ctl.scala 66:13]
      rdat_cnt_r <= 4'h0; // @[axi_r_ctl.scala 67:16]
    end else if (burst_start) begin // @[axi_r_ctl.scala 68:26]
      if (_rack_T) begin // @[axi_r_ctl.scala 72:21]
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
module Queue_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [3:0]  io_enq_bits_awid,
  input  [31:0] io_enq_bits_awaddr,
  input  [1:0]  io_enq_bits_awbusrt,
  input         io_deq_ready,
  output        io_deq_valid,
  output [3:0]  io_deq_bits_awid,
  output [31:0] io_deq_bits_awaddr,
  output [1:0]  io_deq_bits_awbusrt
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] ram_awid [0:2]; // @[Decoupled.scala 273:95]
  wire  ram_awid_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_awid_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [3:0] ram_awid_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_awid_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_awid_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_awid_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_awid_MPORT_en; // @[Decoupled.scala 273:95]
  reg [31:0] ram_awaddr [0:2]; // @[Decoupled.scala 273:95]
  wire  ram_awaddr_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_awaddr_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [31:0] ram_awaddr_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [31:0] ram_awaddr_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_awaddr_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_awaddr_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_awaddr_MPORT_en; // @[Decoupled.scala 273:95]
  reg [1:0] ram_awbusrt [0:2]; // @[Decoupled.scala 273:95]
  wire  ram_awbusrt_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_awbusrt_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [1:0] ram_awbusrt_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_awbusrt_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_awbusrt_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_awbusrt_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_awbusrt_MPORT_en; // @[Decoupled.scala 273:95]
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
  assign ram_awid_io_deq_bits_MPORT_en = 1'h1;
  assign ram_awid_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_awid_io_deq_bits_MPORT_data = ram_awid[ram_awid_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_awid_io_deq_bits_MPORT_data = ram_awid_io_deq_bits_MPORT_addr >= 2'h3 ? _RAND_1[3:0] :
    ram_awid[ram_awid_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_awid_MPORT_data = io_enq_bits_awid;
  assign ram_awid_MPORT_addr = enq_ptr_value;
  assign ram_awid_MPORT_mask = 1'h1;
  assign ram_awid_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_awaddr_io_deq_bits_MPORT_en = 1'h1;
  assign ram_awaddr_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_awaddr_io_deq_bits_MPORT_data = ram_awaddr[ram_awaddr_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_awaddr_io_deq_bits_MPORT_data = ram_awaddr_io_deq_bits_MPORT_addr >= 2'h3 ? _RAND_3[31:0] :
    ram_awaddr[ram_awaddr_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_awaddr_MPORT_data = io_enq_bits_awaddr;
  assign ram_awaddr_MPORT_addr = enq_ptr_value;
  assign ram_awaddr_MPORT_mask = 1'h1;
  assign ram_awaddr_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_awbusrt_io_deq_bits_MPORT_en = 1'h1;
  assign ram_awbusrt_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_awbusrt_io_deq_bits_MPORT_data = ram_awbusrt[ram_awbusrt_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_awbusrt_io_deq_bits_MPORT_data = ram_awbusrt_io_deq_bits_MPORT_addr >= 2'h3 ? _RAND_5[1:0] :
    ram_awbusrt[ram_awbusrt_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_awbusrt_MPORT_data = io_enq_bits_awbusrt;
  assign ram_awbusrt_MPORT_addr = enq_ptr_value;
  assign ram_awbusrt_MPORT_mask = 1'h1;
  assign ram_awbusrt_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 303:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits_awid = ram_awid_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_awaddr = ram_awaddr_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_awbusrt = ram_awbusrt_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_awid_MPORT_en & ram_awid_MPORT_mask) begin
      ram_awid[ram_awid_MPORT_addr] <= ram_awid_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_awaddr_MPORT_en & ram_awaddr_MPORT_mask) begin
      ram_awaddr[ram_awaddr_MPORT_addr] <= ram_awaddr_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_awbusrt_MPORT_en & ram_awbusrt_MPORT_mask) begin
      ram_awbusrt[ram_awbusrt_MPORT_addr] <= ram_awbusrt_MPORT_data; // @[Decoupled.scala 273:95]
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
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_awid[initvar] = _RAND_0[3:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_awaddr[initvar] = _RAND_2[31:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_awbusrt[initvar] = _RAND_4[1:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  enq_ptr_value = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  deq_ptr_value = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  maybe_full = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module axi_fifo_1(
  input         clock,
  input         reset,
  output        io_wr_ready,
  input         io_wr_valid,
  input  [3:0]  io_wr_bits_awid,
  input  [31:0] io_wr_bits_awaddr,
  input  [1:0]  io_wr_bits_awbusrt,
  input         io_rd_ready,
  output [3:0]  io_rd_bits_awid,
  output [31:0] io_rd_bits_awaddr,
  output [1:0]  io_rd_bits_awbusrt
);
  wire  io_rd_q_clock; // @[Decoupled.scala 375:21]
  wire  io_rd_q_reset; // @[Decoupled.scala 375:21]
  wire  io_rd_q_io_enq_ready; // @[Decoupled.scala 375:21]
  wire  io_rd_q_io_enq_valid; // @[Decoupled.scala 375:21]
  wire [3:0] io_rd_q_io_enq_bits_awid; // @[Decoupled.scala 375:21]
  wire [31:0] io_rd_q_io_enq_bits_awaddr; // @[Decoupled.scala 375:21]
  wire [1:0] io_rd_q_io_enq_bits_awbusrt; // @[Decoupled.scala 375:21]
  wire  io_rd_q_io_deq_ready; // @[Decoupled.scala 375:21]
  wire  io_rd_q_io_deq_valid; // @[Decoupled.scala 375:21]
  wire [3:0] io_rd_q_io_deq_bits_awid; // @[Decoupled.scala 375:21]
  wire [31:0] io_rd_q_io_deq_bits_awaddr; // @[Decoupled.scala 375:21]
  wire [1:0] io_rd_q_io_deq_bits_awbusrt; // @[Decoupled.scala 375:21]
  Queue_1 io_rd_q ( // @[Decoupled.scala 375:21]
    .clock(io_rd_q_clock),
    .reset(io_rd_q_reset),
    .io_enq_ready(io_rd_q_io_enq_ready),
    .io_enq_valid(io_rd_q_io_enq_valid),
    .io_enq_bits_awid(io_rd_q_io_enq_bits_awid),
    .io_enq_bits_awaddr(io_rd_q_io_enq_bits_awaddr),
    .io_enq_bits_awbusrt(io_rd_q_io_enq_bits_awbusrt),
    .io_deq_ready(io_rd_q_io_deq_ready),
    .io_deq_valid(io_rd_q_io_deq_valid),
    .io_deq_bits_awid(io_rd_q_io_deq_bits_awid),
    .io_deq_bits_awaddr(io_rd_q_io_deq_bits_awaddr),
    .io_deq_bits_awbusrt(io_rd_q_io_deq_bits_awbusrt)
  );
  assign io_wr_ready = io_rd_q_io_enq_ready; // @[Decoupled.scala 379:17]
  assign io_rd_bits_awid = io_rd_q_io_deq_bits_awid; // @[axi_fifo.scala 15:9]
  assign io_rd_bits_awaddr = io_rd_q_io_deq_bits_awaddr; // @[axi_fifo.scala 15:9]
  assign io_rd_bits_awbusrt = io_rd_q_io_deq_bits_awbusrt; // @[axi_fifo.scala 15:9]
  assign io_rd_q_clock = clock;
  assign io_rd_q_reset = reset;
  assign io_rd_q_io_enq_valid = io_wr_valid; // @[Decoupled.scala 377:22]
  assign io_rd_q_io_enq_bits_awid = io_wr_bits_awid; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_enq_bits_awaddr = io_wr_bits_awaddr; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_enq_bits_awbusrt = io_wr_bits_awbusrt; // @[Decoupled.scala 378:21]
  assign io_rd_q_io_deq_ready = io_rd_ready; // @[axi_fifo.scala 15:9]
endmodule
module axi_w_ctl(
  input         clock,
  input         reset,
  output        io_axi_aw_ready,
  input         io_axi_aw_valid,
  input  [3:0]  io_axi_aw_bits_awid,
  input  [31:0] io_axi_aw_bits_awaddr,
  input  [1:0]  io_axi_aw_bits_awbusrt,
  output        io_axi_w_ready,
  input         io_axi_w_valid,
  input  [31:0] io_axi_w_bits_wdata,
  input  [3:0]  io_axi_w_bits_wstrb,
  input         io_axi_w_bits_wlast,
  input         io_axi_b_ready,
  output        io_axi_b_valid,
  output [3:0]  io_axi_b_bits_bid,
  output [31:0] io_adr,
  output        io_wen,
  output [3:0]  io_wstrb,
  output [31:0] io_wdat,
  input         io_free
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  axi_aw_fifo_clock; // @[axi_w_ctl.scala 34:27]
  wire  axi_aw_fifo_reset; // @[axi_w_ctl.scala 34:27]
  wire  axi_aw_fifo_io_wr_ready; // @[axi_w_ctl.scala 34:27]
  wire  axi_aw_fifo_io_wr_valid; // @[axi_w_ctl.scala 34:27]
  wire [3:0] axi_aw_fifo_io_wr_bits_awid; // @[axi_w_ctl.scala 34:27]
  wire [31:0] axi_aw_fifo_io_wr_bits_awaddr; // @[axi_w_ctl.scala 34:27]
  wire [1:0] axi_aw_fifo_io_wr_bits_awbusrt; // @[axi_w_ctl.scala 34:27]
  wire  axi_aw_fifo_io_rd_ready; // @[axi_w_ctl.scala 34:27]
  wire [3:0] axi_aw_fifo_io_rd_bits_awid; // @[axi_w_ctl.scala 34:27]
  wire [31:0] axi_aw_fifo_io_rd_bits_awaddr; // @[axi_w_ctl.scala 34:27]
  wire [1:0] axi_aw_fifo_io_rd_bits_awbusrt; // @[axi_w_ctl.scala 34:27]
  wire  awack = io_axi_aw_valid & io_axi_aw_ready; // @[axi_w_ctl.scala 33:31]
  reg  aw_ready_r; // @[axi_w_ctl.scala 37:27]
  reg [3:0] wdat_cnt_r; // @[axi_w_ctl.scala 53:27]
  wire  wrap_mode = axi_aw_fifo_io_rd_bits_awbusrt == 2'h2; // @[axi_w_ctl.scala 56:50]
  wire  incr_mode = axi_aw_fifo_io_rd_bits_awbusrt == 2'h1; // @[axi_w_ctl.scala 57:50]
  wire  fixed_mode = axi_aw_fifo_io_rd_bits_awbusrt == 2'h0; // @[axi_w_ctl.scala 58:51]
  wire  burst_start = wrap_mode | incr_mode | fixed_mode; // @[axi_w_ctl.scala 59:43]
  wire [31:0] _GEN_10 = {{28'd0}, wdat_cnt_r}; // @[axi_w_ctl.scala 63:49]
  wire [31:0] burst_adr = axi_aw_fifo_io_rd_bits_awaddr + _GEN_10; // @[axi_w_ctl.scala 63:49]
  wire  _wack_T = io_axi_w_valid & io_axi_w_ready; // @[axi_w_ctl.scala 65:29]
  wire  wack = io_axi_w_valid & io_axi_w_ready & io_axi_w_bits_wlast; // @[axi_w_ctl.scala 65:47]
  wire  back = io_axi_b_valid & io_axi_b_ready; // @[axi_w_ctl.scala 66:29]
  reg [3:0] bid_r; // @[axi_w_ctl.scala 68:25]
  reg  bvalid_r; // @[axi_w_ctl.scala 70:25]
  wire  _GEN_2 = back ? 1'h0 : bvalid_r; // @[axi_w_ctl.scala 76:19 77:14 70:25]
  wire  _GEN_5 = wack | _GEN_2; // @[axi_w_ctl.scala 72:13 73:14]
  wire [3:0] _wdat_cnt_in_T_2 = wdat_cnt_r + 4'h1; // @[axi_w_ctl.scala 89:32]
  wire [31:0] _io_adr_T = axi_aw_fifo_io_rd_bits_awaddr; // @[Mux.scala 101:16]
  wire [31:0] _io_adr_T_1 = incr_mode ? burst_adr : _io_adr_T; // @[Mux.scala 101:16]
  axi_fifo_1 axi_aw_fifo ( // @[axi_w_ctl.scala 34:27]
    .clock(axi_aw_fifo_clock),
    .reset(axi_aw_fifo_reset),
    .io_wr_ready(axi_aw_fifo_io_wr_ready),
    .io_wr_valid(axi_aw_fifo_io_wr_valid),
    .io_wr_bits_awid(axi_aw_fifo_io_wr_bits_awid),
    .io_wr_bits_awaddr(axi_aw_fifo_io_wr_bits_awaddr),
    .io_wr_bits_awbusrt(axi_aw_fifo_io_wr_bits_awbusrt),
    .io_rd_ready(axi_aw_fifo_io_rd_ready),
    .io_rd_bits_awid(axi_aw_fifo_io_rd_bits_awid),
    .io_rd_bits_awaddr(axi_aw_fifo_io_rd_bits_awaddr),
    .io_rd_bits_awbusrt(axi_aw_fifo_io_rd_bits_awbusrt)
  );
  assign io_axi_aw_ready = aw_ready_r; // @[axi_w_ctl.scala 45:19]
  assign io_axi_w_ready = io_free; // @[axi_w_ctl.scala 101:18]
  assign io_axi_b_valid = bvalid_r; // @[axi_w_ctl.scala 102:18]
  assign io_axi_b_bits_bid = bid_r; // @[axi_w_ctl.scala 103:21]
  assign io_adr = fixed_mode ? axi_aw_fifo_io_rd_bits_awaddr : _io_adr_T_1; // @[Mux.scala 101:16]
  assign io_wen = io_axi_w_valid; // @[axi_w_ctl.scala 98:10]
  assign io_wstrb = io_axi_w_bits_wstrb; // @[axi_w_ctl.scala 99:12]
  assign io_wdat = io_axi_w_bits_wdata; // @[axi_w_ctl.scala 100:11]
  assign axi_aw_fifo_clock = clock;
  assign axi_aw_fifo_reset = reset;
  assign axi_aw_fifo_io_wr_valid = io_axi_aw_valid & io_axi_aw_ready; // @[axi_w_ctl.scala 33:31]
  assign axi_aw_fifo_io_wr_bits_awid = io_axi_aw_bits_awid; // @[axi_w_ctl.scala 48:27]
  assign axi_aw_fifo_io_wr_bits_awaddr = io_axi_aw_bits_awaddr; // @[axi_w_ctl.scala 48:27]
  assign axi_aw_fifo_io_wr_bits_awbusrt = io_axi_aw_bits_awbusrt; // @[axi_w_ctl.scala 48:27]
  assign axi_aw_fifo_io_rd_ready = io_axi_w_valid & io_axi_w_ready & io_axi_w_bits_wlast; // @[axi_w_ctl.scala 65:47]
  always @(posedge clock) begin
    if (reset) begin // @[axi_w_ctl.scala 37:27]
      aw_ready_r <= 1'h0; // @[axi_w_ctl.scala 37:27]
    end else if (awack) begin // @[axi_w_ctl.scala 40:14]
      aw_ready_r <= 1'h0; // @[axi_w_ctl.scala 41:16]
    end else if (io_axi_aw_valid) begin // @[axi_w_ctl.scala 42:30]
      aw_ready_r <= axi_aw_fifo_io_wr_ready; // @[axi_w_ctl.scala 43:16]
    end
    if (reset) begin // @[axi_w_ctl.scala 53:27]
      wdat_cnt_r <= 4'h0; // @[axi_w_ctl.scala 53:27]
    end else if (wack) begin // @[axi_w_ctl.scala 82:13]
      wdat_cnt_r <= 4'h0; // @[axi_w_ctl.scala 83:16]
    end else if (burst_start) begin // @[axi_w_ctl.scala 84:26]
      if (_wack_T) begin // @[axi_w_ctl.scala 88:21]
        wdat_cnt_r <= _wdat_cnt_in_T_2;
      end
    end
    if (reset) begin // @[axi_w_ctl.scala 68:25]
      bid_r <= 4'h0; // @[axi_w_ctl.scala 68:25]
    end else if (wack) begin // @[axi_w_ctl.scala 72:13]
      bid_r <= axi_aw_fifo_io_rd_bits_awid; // @[axi_w_ctl.scala 74:14]
    end else if (back) begin // @[axi_w_ctl.scala 76:19]
      bid_r <= 4'h0; // @[axi_w_ctl.scala 78:14]
    end
    if (reset) begin // @[axi_w_ctl.scala 70:25]
      bvalid_r <= 1'h0; // @[axi_w_ctl.scala 70:25]
    end else begin
      bvalid_r <= _GEN_5;
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
  aw_ready_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  wdat_cnt_r = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  bid_r = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  bvalid_r = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
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
  input         io_rvld,
  input         io_free
);
  wire  axi_r_ctl_clock; // @[axi_ram_ctl.scala 38:25]
  wire  axi_r_ctl_reset; // @[axi_ram_ctl.scala 38:25]
  wire  axi_r_ctl_io_axi_ar_ready; // @[axi_ram_ctl.scala 38:25]
  wire  axi_r_ctl_io_axi_ar_valid; // @[axi_ram_ctl.scala 38:25]
  wire [3:0] axi_r_ctl_io_axi_ar_bits_arid; // @[axi_ram_ctl.scala 38:25]
  wire [31:0] axi_r_ctl_io_axi_ar_bits_araddr; // @[axi_ram_ctl.scala 38:25]
  wire [3:0] axi_r_ctl_io_axi_ar_bits_arlen; // @[axi_ram_ctl.scala 38:25]
  wire [1:0] axi_r_ctl_io_axi_ar_bits_arbusrt; // @[axi_ram_ctl.scala 38:25]
  wire  axi_r_ctl_io_axi_r_ready; // @[axi_ram_ctl.scala 38:25]
  wire  axi_r_ctl_io_axi_r_valid; // @[axi_ram_ctl.scala 38:25]
  wire [31:0] axi_r_ctl_io_axi_r_bits_rdata; // @[axi_ram_ctl.scala 38:25]
  wire [3:0] axi_r_ctl_io_axi_r_bits_rid; // @[axi_ram_ctl.scala 38:25]
  wire  axi_r_ctl_io_axi_r_bits_rlast; // @[axi_ram_ctl.scala 38:25]
  wire [31:0] axi_r_ctl_io_adr; // @[axi_ram_ctl.scala 38:25]
  wire  axi_r_ctl_io_ren; // @[axi_ram_ctl.scala 38:25]
  wire [31:0] axi_r_ctl_io_rdat; // @[axi_ram_ctl.scala 38:25]
  wire  axi_r_ctl_io_rvld; // @[axi_ram_ctl.scala 38:25]
  wire  axi_w_ctl_clock; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_reset; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_axi_aw_ready; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_axi_aw_valid; // @[axi_ram_ctl.scala 39:25]
  wire [3:0] axi_w_ctl_io_axi_aw_bits_awid; // @[axi_ram_ctl.scala 39:25]
  wire [31:0] axi_w_ctl_io_axi_aw_bits_awaddr; // @[axi_ram_ctl.scala 39:25]
  wire [1:0] axi_w_ctl_io_axi_aw_bits_awbusrt; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_axi_w_ready; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_axi_w_valid; // @[axi_ram_ctl.scala 39:25]
  wire [31:0] axi_w_ctl_io_axi_w_bits_wdata; // @[axi_ram_ctl.scala 39:25]
  wire [3:0] axi_w_ctl_io_axi_w_bits_wstrb; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_axi_w_bits_wlast; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_axi_b_ready; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_axi_b_valid; // @[axi_ram_ctl.scala 39:25]
  wire [3:0] axi_w_ctl_io_axi_b_bits_bid; // @[axi_ram_ctl.scala 39:25]
  wire [31:0] axi_w_ctl_io_adr; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_wen; // @[axi_ram_ctl.scala 39:25]
  wire [3:0] axi_w_ctl_io_wstrb; // @[axi_ram_ctl.scala 39:25]
  wire [31:0] axi_w_ctl_io_wdat; // @[axi_ram_ctl.scala 39:25]
  wire  axi_w_ctl_io_free; // @[axi_ram_ctl.scala 39:25]
  wire [31:0] _io_adr_T = axi_w_ctl_io_wen ? axi_w_ctl_io_adr : 32'h0; // @[axi_ram_ctl.scala 50:16]
  axi_r_ctl axi_r_ctl ( // @[axi_ram_ctl.scala 38:25]
    .clock(axi_r_ctl_clock),
    .reset(axi_r_ctl_reset),
    .io_axi_ar_ready(axi_r_ctl_io_axi_ar_ready),
    .io_axi_ar_valid(axi_r_ctl_io_axi_ar_valid),
    .io_axi_ar_bits_arid(axi_r_ctl_io_axi_ar_bits_arid),
    .io_axi_ar_bits_araddr(axi_r_ctl_io_axi_ar_bits_araddr),
    .io_axi_ar_bits_arlen(axi_r_ctl_io_axi_ar_bits_arlen),
    .io_axi_ar_bits_arbusrt(axi_r_ctl_io_axi_ar_bits_arbusrt),
    .io_axi_r_ready(axi_r_ctl_io_axi_r_ready),
    .io_axi_r_valid(axi_r_ctl_io_axi_r_valid),
    .io_axi_r_bits_rdata(axi_r_ctl_io_axi_r_bits_rdata),
    .io_axi_r_bits_rid(axi_r_ctl_io_axi_r_bits_rid),
    .io_axi_r_bits_rlast(axi_r_ctl_io_axi_r_bits_rlast),
    .io_adr(axi_r_ctl_io_adr),
    .io_ren(axi_r_ctl_io_ren),
    .io_rdat(axi_r_ctl_io_rdat),
    .io_rvld(axi_r_ctl_io_rvld)
  );
  axi_w_ctl axi_w_ctl ( // @[axi_ram_ctl.scala 39:25]
    .clock(axi_w_ctl_clock),
    .reset(axi_w_ctl_reset),
    .io_axi_aw_ready(axi_w_ctl_io_axi_aw_ready),
    .io_axi_aw_valid(axi_w_ctl_io_axi_aw_valid),
    .io_axi_aw_bits_awid(axi_w_ctl_io_axi_aw_bits_awid),
    .io_axi_aw_bits_awaddr(axi_w_ctl_io_axi_aw_bits_awaddr),
    .io_axi_aw_bits_awbusrt(axi_w_ctl_io_axi_aw_bits_awbusrt),
    .io_axi_w_ready(axi_w_ctl_io_axi_w_ready),
    .io_axi_w_valid(axi_w_ctl_io_axi_w_valid),
    .io_axi_w_bits_wdata(axi_w_ctl_io_axi_w_bits_wdata),
    .io_axi_w_bits_wstrb(axi_w_ctl_io_axi_w_bits_wstrb),
    .io_axi_w_bits_wlast(axi_w_ctl_io_axi_w_bits_wlast),
    .io_axi_b_ready(axi_w_ctl_io_axi_b_ready),
    .io_axi_b_valid(axi_w_ctl_io_axi_b_valid),
    .io_axi_b_bits_bid(axi_w_ctl_io_axi_b_bits_bid),
    .io_adr(axi_w_ctl_io_adr),
    .io_wen(axi_w_ctl_io_wen),
    .io_wstrb(axi_w_ctl_io_wstrb),
    .io_wdat(axi_w_ctl_io_wdat),
    .io_free(axi_w_ctl_io_free)
  );
  assign io_axi_mst_ar_chl_ready = axi_r_ctl_io_axi_ar_ready; // @[axi_ram_ctl.scala 40:23]
  assign io_axi_mst_r_chl_valid = axi_r_ctl_io_axi_r_valid; // @[axi_ram_ctl.scala 41:23]
  assign io_axi_mst_r_chl_bits_rdata = axi_r_ctl_io_axi_r_bits_rdata; // @[axi_ram_ctl.scala 41:23]
  assign io_axi_mst_r_chl_bits_rid = axi_r_ctl_io_axi_r_bits_rid; // @[axi_ram_ctl.scala 41:23]
  assign io_axi_mst_r_chl_bits_rresp = 2'h0; // @[axi_ram_ctl.scala 41:23]
  assign io_axi_mst_r_chl_bits_rlast = axi_r_ctl_io_axi_r_bits_rlast; // @[axi_ram_ctl.scala 41:23]
  assign io_axi_mst_aw_chl_ready = axi_w_ctl_io_axi_aw_ready; // @[axi_ram_ctl.scala 42:23]
  assign io_axi_mst_w_chl_ready = axi_w_ctl_io_axi_w_ready; // @[axi_ram_ctl.scala 43:23]
  assign io_axi_mst_b_chl_valid = axi_w_ctl_io_axi_b_valid; // @[axi_ram_ctl.scala 44:23]
  assign io_axi_mst_b_chl_bits_bid = axi_w_ctl_io_axi_b_bits_bid; // @[axi_ram_ctl.scala 44:23]
  assign io_axi_mst_b_chl_bits_bresp = 2'h0; // @[axi_ram_ctl.scala 44:23]
  assign io_adr = axi_r_ctl_io_ren ? axi_r_ctl_io_adr : _io_adr_T; // @[axi_ram_ctl.scala 49:16]
  assign io_ren = axi_r_ctl_io_ren; // @[axi_ram_ctl.scala 51:10]
  assign io_wen = axi_w_ctl_io_wen; // @[axi_ram_ctl.scala 52:10]
  assign io_wstrb = axi_w_ctl_io_wstrb; // @[axi_ram_ctl.scala 53:12]
  assign io_wdat = axi_w_ctl_io_wdat; // @[axi_ram_ctl.scala 54:11]
  assign axi_r_ctl_clock = clock;
  assign axi_r_ctl_reset = reset;
  assign axi_r_ctl_io_axi_ar_valid = io_axi_mst_ar_chl_valid; // @[axi_ram_ctl.scala 40:23]
  assign axi_r_ctl_io_axi_ar_bits_arid = io_axi_mst_ar_chl_bits_arid; // @[axi_ram_ctl.scala 40:23]
  assign axi_r_ctl_io_axi_ar_bits_araddr = io_axi_mst_ar_chl_bits_araddr; // @[axi_ram_ctl.scala 40:23]
  assign axi_r_ctl_io_axi_ar_bits_arlen = io_axi_mst_ar_chl_bits_arlen; // @[axi_ram_ctl.scala 40:23]
  assign axi_r_ctl_io_axi_ar_bits_arbusrt = io_axi_mst_ar_chl_bits_arbusrt; // @[axi_ram_ctl.scala 40:23]
  assign axi_r_ctl_io_axi_r_ready = io_axi_mst_r_chl_ready; // @[axi_ram_ctl.scala 41:23]
  assign axi_r_ctl_io_rdat = io_rdat; // @[axi_ram_ctl.scala 57:21]
  assign axi_r_ctl_io_rvld = io_rvld; // @[axi_ram_ctl.scala 56:21]
  assign axi_w_ctl_clock = clock;
  assign axi_w_ctl_reset = reset;
  assign axi_w_ctl_io_axi_aw_valid = io_axi_mst_aw_chl_valid; // @[axi_ram_ctl.scala 42:23]
  assign axi_w_ctl_io_axi_aw_bits_awid = io_axi_mst_aw_chl_bits_awid; // @[axi_ram_ctl.scala 42:23]
  assign axi_w_ctl_io_axi_aw_bits_awaddr = io_axi_mst_aw_chl_bits_awaddr; // @[axi_ram_ctl.scala 42:23]
  assign axi_w_ctl_io_axi_aw_bits_awbusrt = io_axi_mst_aw_chl_bits_awbusrt; // @[axi_ram_ctl.scala 42:23]
  assign axi_w_ctl_io_axi_w_valid = io_axi_mst_w_chl_valid; // @[axi_ram_ctl.scala 43:23]
  assign axi_w_ctl_io_axi_w_bits_wdata = io_axi_mst_w_chl_bits_wdata; // @[axi_ram_ctl.scala 43:23]
  assign axi_w_ctl_io_axi_w_bits_wstrb = io_axi_mst_w_chl_bits_wstrb; // @[axi_ram_ctl.scala 43:23]
  assign axi_w_ctl_io_axi_w_bits_wlast = io_axi_mst_w_chl_bits_wlast; // @[axi_ram_ctl.scala 43:23]
  assign axi_w_ctl_io_axi_b_ready = io_axi_mst_b_chl_ready; // @[axi_ram_ctl.scala 44:23]
  assign axi_w_ctl_io_free = io_free; // @[axi_ram_ctl.scala 55:21]
endmodule
