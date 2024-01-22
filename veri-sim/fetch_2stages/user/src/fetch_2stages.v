module fetch_l0(
  input         clock,
  input         reset,
  input         io_restart_bus_branch_bus_vld,
  input  [63:0] io_restart_bus_branch_bus_adr,
  input         io_fe_br_bus_branch_bus_vld,
  input  [63:0] io_fe_br_bus_branch_bus_adr,
  input         io_be_br_bus_branch_bus_vld,
  input  [63:0] io_be_br_bus_branch_bus_adr,
  output        io_fetch_bus_req,
  output [63:0] io_fetch_bus_adr,
  output [63:0] io_fetch_bus_nadr,
  input         io_fetch_bus_ack,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] pc; // @[fetch_v1.scala 46:21]
  wire [63:0] _npc_T_1 = pc + 64'h10; // @[fetch_v1.scala 54:44]
  wire [63:0] _npc_T_2 = io_fetch_bus_ack ? _npc_T_1 : pc; // @[Mux.scala 101:16]
  wire [63:0] _npc_T_3 = io_fe_br_bus_branch_bus_vld ? io_fe_br_bus_branch_bus_adr : _npc_T_2; // @[Mux.scala 101:16]
  wire [63:0] _npc_T_4 = io_be_br_bus_branch_bus_vld ? io_be_br_bus_branch_bus_adr : _npc_T_3; // @[Mux.scala 101:16]
  assign io_fetch_bus_req = io_deq_ready; // @[fetch_v1.scala 61:39]
  assign io_fetch_bus_adr = pc; // @[fetch_v1.scala 62:23]
  assign io_fetch_bus_nadr = io_restart_bus_branch_bus_vld ? io_restart_bus_branch_bus_adr : _npc_T_4; // @[Mux.scala 101:16]
  assign io_deq_valid = io_fetch_bus_ack; // @[fetch_v1.scala 65:18]
  assign io_deq_bits = pc; // @[fetch_v1.scala 66:18]
  always @(posedge clock) begin
    if (reset) begin // @[fetch_v1.scala 46:21]
      pc <= 64'h80000000; // @[fetch_v1.scala 46:21]
    end else if (io_restart_bus_branch_bus_vld) begin // @[Mux.scala 101:16]
      pc <= io_restart_bus_branch_bus_adr;
    end else if (io_be_br_bus_branch_bus_vld) begin // @[Mux.scala 101:16]
      pc <= io_be_br_bus_branch_bus_adr;
    end else if (io_fe_br_bus_branch_bus_vld) begin // @[Mux.scala 101:16]
      pc <= io_fe_br_bus_branch_bus_adr;
    end else begin
      pc <= _npc_T_2;
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
  _RAND_0 = {2{`RANDOM}};
  pc = _RAND_0[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module pipeline(
  input         clock,
  input         reset,
  output        enq_ready,
  input         enq_valid,
  input  [63:0] enq_bits,
  input         deq_ready,
  output        deq_valid,
  output [63:0] deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  fire = enq_valid & enq_ready; // @[core_bus.scala 84:25]
  reg  vld; // @[core_bus.scala 85:21]
  wire  _GEN_0 = fire | vld; // @[core_bus.scala 87:{14,20} 85:21]
  reg [63:0] bits; // @[Reg.scala 19:16]
  assign enq_ready = deq_ready; // @[core_bus.scala 91:14]
  assign deq_valid = vld; // @[core_bus.scala 90:14]
  assign deq_bits = bits; // @[core_bus.scala 95:13]
  always @(posedge clock) begin
    if (reset) begin // @[core_bus.scala 85:21]
      vld <= 1'h0; // @[core_bus.scala 85:21]
    end else begin
      vld <= _GEN_0;
    end
    if (fire) begin // @[Reg.scala 20:18]
      bits <= enq_bits; // @[Reg.scala 20:22]
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
  vld = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  bits = _RAND_1[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fetch_l1(
  input         clock,
  input         reset,
  output        io_bpu_bus_req,
  output [63:0] io_bpu_bus_adr,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
  wire  io_deq_pp_clock; // @[core_bus.scala 101:22]
  wire  io_deq_pp_reset; // @[core_bus.scala 101:22]
  wire  io_deq_pp_enq_ready; // @[core_bus.scala 101:22]
  wire  io_deq_pp_enq_valid; // @[core_bus.scala 101:22]
  wire [63:0] io_deq_pp_enq_bits; // @[core_bus.scala 101:22]
  wire  io_deq_pp_deq_ready; // @[core_bus.scala 101:22]
  wire  io_deq_pp_deq_valid; // @[core_bus.scala 101:22]
  wire [63:0] io_deq_pp_deq_bits; // @[core_bus.scala 101:22]
  pipeline io_deq_pp ( // @[core_bus.scala 101:22]
    .clock(io_deq_pp_clock),
    .reset(io_deq_pp_reset),
    .enq_ready(io_deq_pp_enq_ready),
    .enq_valid(io_deq_pp_enq_valid),
    .enq_bits(io_deq_pp_enq_bits),
    .deq_ready(io_deq_pp_deq_ready),
    .deq_valid(io_deq_pp_deq_valid),
    .deq_bits(io_deq_pp_deq_bits)
  );
  assign io_bpu_bus_req = io_deq_valid; // @[fetch_v1.scala 82:21]
  assign io_bpu_bus_adr = io_deq_bits; // @[fetch_v1.scala 83:21]
  assign io_enq_ready = io_deq_pp_enq_ready; // @[core_bus.scala 103:14]
  assign io_deq_valid = io_deq_pp_deq_valid; // @[fetch_v1.scala 80:12]
  assign io_deq_bits = io_deq_pp_deq_bits; // @[fetch_v1.scala 80:12]
  assign io_deq_pp_clock = clock;
  assign io_deq_pp_reset = reset; // @[core_bus.scala 102:16]
  assign io_deq_pp_enq_valid = io_enq_valid; // @[core_bus.scala 103:14]
  assign io_deq_pp_enq_bits = io_enq_bits; // @[core_bus.scala 103:14]
  assign io_deq_pp_deq_ready = io_deq_ready; // @[fetch_v1.scala 80:12]
endmodule
module fetch_2stages(
  input         clock,
  input         reset,
  input         io_l0_restart_bus_branch_bus_vld,
  input  [63:0] io_l0_restart_bus_branch_bus_adr,
  input         io_l0_fe_br_bus_branch_bus_vld,
  input  [63:0] io_l0_fe_br_bus_branch_bus_adr,
  input         io_l0_be_br_bus_branch_bus_vld,
  input  [63:0] io_l0_be_br_bus_branch_bus_adr,
  output        io_l0_fetch_bus_req,
  output [63:0] io_l0_fetch_bus_adr,
  output [63:0] io_l0_fetch_bus_nadr,
  input         io_l0_fetch_bus_ack,
  output        io_l1_bpu_bus_req,
  output [63:0] io_l1_bpu_bus_adr,
  output [63:0] io_l1_bpu_bus_nadr,
  input         io_l1_bpu_bus_ack,
  input         out_ready,
  output        out_valid,
  output [63:0] out_pc
);
  wire  l0_clock; // @[fetch_v1.scala 102:20]
  wire  l0_reset; // @[fetch_v1.scala 102:20]
  wire  l0_io_restart_bus_branch_bus_vld; // @[fetch_v1.scala 102:20]
  wire [63:0] l0_io_restart_bus_branch_bus_adr; // @[fetch_v1.scala 102:20]
  wire  l0_io_fe_br_bus_branch_bus_vld; // @[fetch_v1.scala 102:20]
  wire [63:0] l0_io_fe_br_bus_branch_bus_adr; // @[fetch_v1.scala 102:20]
  wire  l0_io_be_br_bus_branch_bus_vld; // @[fetch_v1.scala 102:20]
  wire [63:0] l0_io_be_br_bus_branch_bus_adr; // @[fetch_v1.scala 102:20]
  wire  l0_io_fetch_bus_req; // @[fetch_v1.scala 102:20]
  wire [63:0] l0_io_fetch_bus_adr; // @[fetch_v1.scala 102:20]
  wire [63:0] l0_io_fetch_bus_nadr; // @[fetch_v1.scala 102:20]
  wire  l0_io_fetch_bus_ack; // @[fetch_v1.scala 102:20]
  wire  l0_io_deq_ready; // @[fetch_v1.scala 102:20]
  wire  l0_io_deq_valid; // @[fetch_v1.scala 102:20]
  wire [63:0] l0_io_deq_bits; // @[fetch_v1.scala 102:20]
  wire  l1_clock; // @[fetch_v1.scala 103:20]
  wire  l1_reset; // @[fetch_v1.scala 103:20]
  wire  l1_io_bpu_bus_req; // @[fetch_v1.scala 103:20]
  wire [63:0] l1_io_bpu_bus_adr; // @[fetch_v1.scala 103:20]
  wire  l1_io_enq_ready; // @[fetch_v1.scala 103:20]
  wire  l1_io_enq_valid; // @[fetch_v1.scala 103:20]
  wire [63:0] l1_io_enq_bits; // @[fetch_v1.scala 103:20]
  wire  l1_io_deq_ready; // @[fetch_v1.scala 103:20]
  wire  l1_io_deq_valid; // @[fetch_v1.scala 103:20]
  wire [63:0] l1_io_deq_bits; // @[fetch_v1.scala 103:20]
  fetch_l0 l0 ( // @[fetch_v1.scala 102:20]
    .clock(l0_clock),
    .reset(l0_reset),
    .io_restart_bus_branch_bus_vld(l0_io_restart_bus_branch_bus_vld),
    .io_restart_bus_branch_bus_adr(l0_io_restart_bus_branch_bus_adr),
    .io_fe_br_bus_branch_bus_vld(l0_io_fe_br_bus_branch_bus_vld),
    .io_fe_br_bus_branch_bus_adr(l0_io_fe_br_bus_branch_bus_adr),
    .io_be_br_bus_branch_bus_vld(l0_io_be_br_bus_branch_bus_vld),
    .io_be_br_bus_branch_bus_adr(l0_io_be_br_bus_branch_bus_adr),
    .io_fetch_bus_req(l0_io_fetch_bus_req),
    .io_fetch_bus_adr(l0_io_fetch_bus_adr),
    .io_fetch_bus_nadr(l0_io_fetch_bus_nadr),
    .io_fetch_bus_ack(l0_io_fetch_bus_ack),
    .io_deq_ready(l0_io_deq_ready),
    .io_deq_valid(l0_io_deq_valid),
    .io_deq_bits(l0_io_deq_bits)
  );
  fetch_l1 l1 ( // @[fetch_v1.scala 103:20]
    .clock(l1_clock),
    .reset(l1_reset),
    .io_bpu_bus_req(l1_io_bpu_bus_req),
    .io_bpu_bus_adr(l1_io_bpu_bus_adr),
    .io_enq_ready(l1_io_enq_ready),
    .io_enq_valid(l1_io_enq_valid),
    .io_enq_bits(l1_io_enq_bits),
    .io_deq_ready(l1_io_deq_ready),
    .io_deq_valid(l1_io_deq_valid),
    .io_deq_bits(l1_io_deq_bits)
  );
  assign io_l0_fetch_bus_req = l0_io_fetch_bus_req; // @[fetch_v1.scala 108:25]
  assign io_l0_fetch_bus_adr = l0_io_fetch_bus_adr; // @[fetch_v1.scala 108:25]
  assign io_l0_fetch_bus_nadr = l0_io_fetch_bus_nadr; // @[fetch_v1.scala 108:25]
  assign io_l1_bpu_bus_req = l1_io_bpu_bus_req; // @[fetch_v1.scala 109:25]
  assign io_l1_bpu_bus_adr = l1_io_bpu_bus_adr; // @[fetch_v1.scala 109:25]
  assign io_l1_bpu_bus_nadr = 64'h0; // @[fetch_v1.scala 109:25]
  assign out_valid = l1_io_deq_valid; // @[fetch_v1.scala 113:12]
  assign out_pc = l1_io_deq_bits; // @[fetch_v1.scala 113:12]
  assign l0_clock = clock;
  assign l0_reset = reset;
  assign l0_io_restart_bus_branch_bus_vld = io_l0_restart_bus_branch_bus_vld; // @[fetch_v1.scala 107:25]
  assign l0_io_restart_bus_branch_bus_adr = io_l0_restart_bus_branch_bus_adr; // @[fetch_v1.scala 107:25]
  assign l0_io_fe_br_bus_branch_bus_vld = io_l0_fe_br_bus_branch_bus_vld; // @[fetch_v1.scala 106:25]
  assign l0_io_fe_br_bus_branch_bus_adr = io_l0_fe_br_bus_branch_bus_adr; // @[fetch_v1.scala 106:25]
  assign l0_io_be_br_bus_branch_bus_vld = io_l0_be_br_bus_branch_bus_vld; // @[fetch_v1.scala 105:25]
  assign l0_io_be_br_bus_branch_bus_adr = io_l0_be_br_bus_branch_bus_adr; // @[fetch_v1.scala 105:25]
  assign l0_io_fetch_bus_ack = io_l0_fetch_bus_ack; // @[fetch_v1.scala 108:25]
  assign l0_io_deq_ready = l1_io_enq_ready; // @[fetch_v1.scala 112:15]
  assign l1_clock = clock;
  assign l1_reset = reset;
  assign l1_io_enq_valid = l0_io_deq_valid; // @[fetch_v1.scala 112:15]
  assign l1_io_enq_bits = l0_io_deq_bits; // @[fetch_v1.scala 112:15]
  assign l1_io_deq_ready = out_ready; // @[fetch_v1.scala 113:12]
endmodule
