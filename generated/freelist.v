module freelist(
  input        clock,
  input        reset,
  input        io_req_0,
  input        io_req_1,
  input        io_req_2,
  input        io_req_3,
  output [5:0] io_pidx_0,
  output [5:0] io_pidx_1,
  output [5:0] io_pidx_2,
  output [5:0] io_pidx_3,
  output       io_pvld_0,
  output       io_pvld_1,
  output       io_pvld_2,
  output       io_pvld_3,
  output       io_busy,
  input        io_rls_0,
  input        io_rls_1,
  input        io_rls_2,
  input        io_rls_3,
  input  [5:0] io_rls_pidx_0,
  input  [5:0] io_rls_pidx_1,
  input  [5:0] io_rls_pidx_2,
  input  [5:0] io_rls_pidx_3
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] idx_r [0:63]; // @[freelist.scala 39:20]
  wire  idx_r_rd_pidx_0_MPORT_en; // @[freelist.scala 39:20]
  wire [5:0] idx_r_rd_pidx_0_MPORT_addr; // @[freelist.scala 39:20]
  wire [5:0] idx_r_rd_pidx_0_MPORT_data; // @[freelist.scala 39:20]
  wire  idx_r_rd_pidx_1_MPORT_en; // @[freelist.scala 39:20]
  wire [5:0] idx_r_rd_pidx_1_MPORT_addr; // @[freelist.scala 39:20]
  wire [5:0] idx_r_rd_pidx_1_MPORT_data; // @[freelist.scala 39:20]
  wire  idx_r_rd_pidx_2_MPORT_en; // @[freelist.scala 39:20]
  wire [5:0] idx_r_rd_pidx_2_MPORT_addr; // @[freelist.scala 39:20]
  wire [5:0] idx_r_rd_pidx_2_MPORT_data; // @[freelist.scala 39:20]
  wire  idx_r_rd_pidx_3_MPORT_en; // @[freelist.scala 39:20]
  wire [5:0] idx_r_rd_pidx_3_MPORT_addr; // @[freelist.scala 39:20]
  wire [5:0] idx_r_rd_pidx_3_MPORT_data; // @[freelist.scala 39:20]
  wire [5:0] idx_r_MPORT_data; // @[freelist.scala 39:20]
  wire [5:0] idx_r_MPORT_addr; // @[freelist.scala 39:20]
  wire  idx_r_MPORT_mask; // @[freelist.scala 39:20]
  wire  idx_r_MPORT_en; // @[freelist.scala 39:20]
  wire [5:0] idx_r_MPORT_1_data; // @[freelist.scala 39:20]
  wire [5:0] idx_r_MPORT_1_addr; // @[freelist.scala 39:20]
  wire  idx_r_MPORT_1_mask; // @[freelist.scala 39:20]
  wire  idx_r_MPORT_1_en; // @[freelist.scala 39:20]
  wire [5:0] idx_r_MPORT_2_data; // @[freelist.scala 39:20]
  wire [5:0] idx_r_MPORT_2_addr; // @[freelist.scala 39:20]
  wire  idx_r_MPORT_2_mask; // @[freelist.scala 39:20]
  wire  idx_r_MPORT_2_en; // @[freelist.scala 39:20]
  wire [5:0] idx_r_MPORT_3_data; // @[freelist.scala 39:20]
  wire [5:0] idx_r_MPORT_3_addr; // @[freelist.scala 39:20]
  wire  idx_r_MPORT_3_mask; // @[freelist.scala 39:20]
  wire  idx_r_MPORT_3_en; // @[freelist.scala 39:20]
  reg [6:0] idx_rptr; // @[freelist.scala 41:27]
  reg [6:0] idx_wptr; // @[freelist.scala 42:27]
  wire  empty = idx_wptr[6:1] == idx_rptr[6:1]; // @[freelist.scala 95:34]
  wire  re = (io_req_0 | io_req_1 | (io_req_2 | io_req_3)) & ~empty; // @[freelist.scala 48:37]
  wire  _full_T_5 = idx_wptr[5:1] == idx_rptr[5:1]; // @[freelist.scala 97:37]
  wire  full = idx_wptr[6] != idx_rptr[6] & _full_T_5; // @[freelist.scala 96:54]
  wire  we = (io_rls_0 | io_rls_1 | (io_rls_2 | io_rls_3)) & ~full; // @[freelist.scala 49:37]
  wire  _r_pidx_sum_T_1 = io_req_0 + io_req_1; // @[freelist.scala 53:61]
  wire  _r_pidx_sum_T_3 = _r_pidx_sum_T_1 + io_req_2; // @[freelist.scala 53:61]
  wire  _r_pidx_sum_T_5 = _r_pidx_sum_T_3 + io_req_3; // @[freelist.scala 53:61]
  wire  _w_pidx_sum_T_1 = io_rls_0 + io_rls_1; // @[freelist.scala 54:61]
  wire  _w_pidx_sum_T_3 = _w_pidx_sum_T_1 + io_rls_2; // @[freelist.scala 54:61]
  wire  _w_pidx_sum_T_5 = _w_pidx_sum_T_3 + io_rls_3; // @[freelist.scala 54:61]
  wire [1:0] r_pidx_sum = {{1'd0}, _r_pidx_sum_T_5}; // @[freelist.scala 51:26 53:16]
  wire  _r_onehot_T = r_pidx_sum > 2'h0; // @[freelist.scala 59:61]
  wire  _r_onehot_T_1 = r_pidx_sum > 2'h1; // @[freelist.scala 59:61]
  wire  _r_onehot_T_2 = r_pidx_sum > 2'h2; // @[freelist.scala 59:61]
  wire [3:0] r_onehot = {1'h0,_r_onehot_T_2,_r_onehot_T_1,_r_onehot_T}; // @[Cat.scala 33:92]
  wire [1:0] w_pidx_sum = {{1'd0}, _w_pidx_sum_T_5}; // @[freelist.scala 52:26 54:16]
  wire  _w_onehot_T = w_pidx_sum > 2'h0; // @[freelist.scala 60:61]
  wire  _w_onehot_T_1 = w_pidx_sum > 2'h1; // @[freelist.scala 60:61]
  wire  _w_onehot_T_2 = w_pidx_sum > 2'h2; // @[freelist.scala 60:61]
  wire [3:0] w_onehot = {1'h0,_w_onehot_T_2,_w_onehot_T_1,_w_onehot_T}; // @[Cat.scala 33:92]
  wire [5:0] _wr_pidx_0_T = io_rls_3 ? io_rls_pidx_3 : 6'h0; // @[Mux.scala 101:16]
  wire [5:0] _wr_pidx_0_T_1 = io_rls_2 ? io_rls_pidx_2 : _wr_pidx_0_T; // @[Mux.scala 101:16]
  wire [5:0] _wr_pidx_0_T_2 = io_rls_1 ? io_rls_pidx_1 : _wr_pidx_0_T_1; // @[Mux.scala 101:16]
  wire [6:0] _GEN_38 = {{5'd0}, r_pidx_sum}; // @[freelist.scala 73:36]
  wire [6:0] _idx_rptr_T_1 = idx_rptr + _GEN_38; // @[freelist.scala 73:36]
  wire [6:0] _GEN_39 = {{5'd0}, w_pidx_sum}; // @[freelist.scala 74:36]
  wire [6:0] _idx_wptr_T_1 = idx_wptr + _GEN_39; // @[freelist.scala 74:36]
  wire [7:0] _T_2 = {{1'd0}, idx_wptr}; // @[freelist.scala 77:47]
  wire  rd_pvld_0 = r_onehot[0] & re; // @[freelist.scala 78:26]
  wire [7:0] _rd_pidx_0_T = {{1'd0}, idx_rptr}; // @[freelist.scala 79:41]
  wire [5:0] rd_pidx_0 = rd_pvld_0 ? idx_r_rd_pidx_0_MPORT_data : 6'h0; // @[freelist.scala 78:31 79:24 82:24]
  wire [6:0] _T_10 = idx_wptr + 7'h1; // @[freelist.scala 77:47]
  wire  rd_pvld_1 = r_onehot[1] & re; // @[freelist.scala 78:26]
  wire [6:0] _rd_pidx_1_T_1 = idx_rptr + 7'h1; // @[freelist.scala 79:41]
  wire [5:0] rd_pidx_1 = rd_pvld_1 ? idx_r_rd_pidx_1_MPORT_data : 6'h0; // @[freelist.scala 78:31 79:24 82:24]
  wire [6:0] _T_17 = idx_wptr + 7'h2; // @[freelist.scala 77:47]
  wire  rd_pvld_2 = r_onehot[2] & re; // @[freelist.scala 78:26]
  wire [6:0] _rd_pidx_2_T_1 = idx_rptr + 7'h2; // @[freelist.scala 79:41]
  wire [5:0] rd_pidx_2 = rd_pvld_2 ? idx_r_rd_pidx_2_MPORT_data : 6'h0; // @[freelist.scala 78:31 79:24 82:24]
  wire [6:0] _T_24 = idx_wptr + 7'h3; // @[freelist.scala 77:47]
  wire  rd_pvld_3 = r_onehot[3] & re; // @[freelist.scala 78:26]
  wire [6:0] _rd_pidx_3_T_1 = idx_rptr + 7'h3; // @[freelist.scala 79:41]
  wire [5:0] rd_pidx_3 = rd_pvld_3 ? idx_r_rd_pidx_3_MPORT_data : 6'h0; // @[freelist.scala 78:31 79:24 82:24]
  wire [5:0] _io_pidx_0_T_4 = r_onehot[3] ? rd_pidx_3 : 6'h0; // @[Mux.scala 101:16]
  wire [5:0] _io_pidx_0_T_5 = r_onehot[2] ? rd_pidx_2 : _io_pidx_0_T_4; // @[Mux.scala 101:16]
  wire [5:0] _io_pidx_0_T_6 = r_onehot[1] ? rd_pidx_1 : _io_pidx_0_T_5; // @[Mux.scala 101:16]
  assign idx_r_rd_pidx_0_MPORT_en = r_onehot[0] & re;
  assign idx_r_rd_pidx_0_MPORT_addr = _rd_pidx_0_T[5:0];
  assign idx_r_rd_pidx_0_MPORT_data = idx_r[idx_r_rd_pidx_0_MPORT_addr]; // @[freelist.scala 39:20]
  assign idx_r_rd_pidx_1_MPORT_en = r_onehot[1] & re;
  assign idx_r_rd_pidx_1_MPORT_addr = _rd_pidx_1_T_1[5:0];
  assign idx_r_rd_pidx_1_MPORT_data = idx_r[idx_r_rd_pidx_1_MPORT_addr]; // @[freelist.scala 39:20]
  assign idx_r_rd_pidx_2_MPORT_en = r_onehot[2] & re;
  assign idx_r_rd_pidx_2_MPORT_addr = _rd_pidx_2_T_1[5:0];
  assign idx_r_rd_pidx_2_MPORT_data = idx_r[idx_r_rd_pidx_2_MPORT_addr]; // @[freelist.scala 39:20]
  assign idx_r_rd_pidx_3_MPORT_en = r_onehot[3] & re;
  assign idx_r_rd_pidx_3_MPORT_addr = _rd_pidx_3_T_1[5:0];
  assign idx_r_rd_pidx_3_MPORT_data = idx_r[idx_r_rd_pidx_3_MPORT_addr]; // @[freelist.scala 39:20]
  assign idx_r_MPORT_data = io_rls_0 ? io_rls_pidx_0 : _wr_pidx_0_T_2;
  assign idx_r_MPORT_addr = _T_2[5:0];
  assign idx_r_MPORT_mask = 1'h1;
  assign idx_r_MPORT_en = w_onehot[0] & we;
  assign idx_r_MPORT_1_data = io_rls_1 ? io_rls_pidx_1 : _wr_pidx_0_T_1;
  assign idx_r_MPORT_1_addr = _T_10[5:0];
  assign idx_r_MPORT_1_mask = 1'h1;
  assign idx_r_MPORT_1_en = w_onehot[1] & we;
  assign idx_r_MPORT_2_data = io_rls_2 ? io_rls_pidx_2 : _wr_pidx_0_T;
  assign idx_r_MPORT_2_addr = _T_17[5:0];
  assign idx_r_MPORT_2_mask = 1'h1;
  assign idx_r_MPORT_2_en = w_onehot[2] & we;
  assign idx_r_MPORT_3_data = io_rls_3 ? io_rls_pidx_3 : 6'h0;
  assign idx_r_MPORT_3_addr = _T_24[5:0];
  assign idx_r_MPORT_3_mask = 1'h1;
  assign idx_r_MPORT_3_en = w_onehot[3] & we;
  assign io_pidx_0 = r_onehot[0] ? rd_pidx_0 : _io_pidx_0_T_6; // @[Mux.scala 101:16]
  assign io_pidx_1 = r_onehot[1] ? rd_pidx_1 : _io_pidx_0_T_5; // @[Mux.scala 101:16]
  assign io_pidx_2 = r_onehot[2] ? rd_pidx_2 : _io_pidx_0_T_4; // @[Mux.scala 101:16]
  assign io_pidx_3 = r_onehot[3] ? rd_pidx_3 : 6'h0; // @[Mux.scala 101:16]
  assign io_pvld_0 = r_onehot[0] | (r_onehot[1] | (r_onehot[2] | r_onehot[3])); // @[Mux.scala 101:16]
  assign io_pvld_1 = r_onehot[1] | (r_onehot[2] | r_onehot[3]); // @[Mux.scala 101:16]
  assign io_pvld_2 = r_onehot[2] | r_onehot[3]; // @[Mux.scala 101:16]
  assign io_pvld_3 = r_onehot[3]; // @[freelist.scala 92:62]
  assign io_busy = idx_wptr[6:1] == idx_rptr[6:1]; // @[freelist.scala 95:34]
  always @(posedge clock) begin
    if (idx_r_MPORT_en & idx_r_MPORT_mask) begin
      idx_r[idx_r_MPORT_addr] <= idx_r_MPORT_data; // @[freelist.scala 39:20]
    end
    if (idx_r_MPORT_1_en & idx_r_MPORT_1_mask) begin
      idx_r[idx_r_MPORT_1_addr] <= idx_r_MPORT_1_data; // @[freelist.scala 39:20]
    end
    if (idx_r_MPORT_2_en & idx_r_MPORT_2_mask) begin
      idx_r[idx_r_MPORT_2_addr] <= idx_r_MPORT_2_data; // @[freelist.scala 39:20]
    end
    if (idx_r_MPORT_3_en & idx_r_MPORT_3_mask) begin
      idx_r[idx_r_MPORT_3_addr] <= idx_r_MPORT_3_data; // @[freelist.scala 39:20]
    end
    if (reset) begin // @[freelist.scala 41:27]
      idx_rptr <= 7'h0; // @[freelist.scala 41:27]
    end else if (re) begin // @[freelist.scala 73:13]
      idx_rptr <= _idx_rptr_T_1; // @[freelist.scala 73:24]
    end
    if (reset) begin // @[freelist.scala 42:27]
      idx_wptr <= 7'h3f; // @[freelist.scala 42:27]
    end else if (we) begin // @[freelist.scala 74:13]
      idx_wptr <= _idx_wptr_T_1; // @[freelist.scala 74:24]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 64; initvar = initvar+1)
    idx_r[initvar] = _RAND_0[5:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  idx_rptr = _RAND_1[6:0];
  _RAND_2 = {1{`RANDOM}};
  idx_wptr = _RAND_2[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
initial begin
  $readmemh("../data/freelist.mem", idx_r);
end
endmodule
