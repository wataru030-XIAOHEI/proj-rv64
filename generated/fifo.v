module fifo(
  input         clock,
  input         reset,
  output        io_wr_ready,
  input         io_wr_valid,
  input  [31:0] io_wr_bits,
  input         io_rd_ready,
  output        io_rd_valid,
  output [31:0] io_rd_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram [0:15]; // @[fifo.scala 17:16]
  wire  ram_rdat_MPORT_en; // @[fifo.scala 17:16]
  wire [3:0] ram_rdat_MPORT_addr; // @[fifo.scala 17:16]
  wire [31:0] ram_rdat_MPORT_data; // @[fifo.scala 17:16]
  wire [31:0] ram_MPORT_data; // @[fifo.scala 17:16]
  wire [3:0] ram_MPORT_addr; // @[fifo.scala 17:16]
  wire  ram_MPORT_mask; // @[fifo.scala 17:16]
  wire  ram_MPORT_en; // @[fifo.scala 17:16]
  reg [4:0] wptr_r; // @[fifo.scala 19:23]
  reg [4:0] rptr_r; // @[fifo.scala 20:23]
  wire  full = wptr_r[4] != rptr_r[4] & wptr_r[3:0] == rptr_r[3:0]; // @[fifo.scala 22:50]
  wire  empty = wptr_r == rptr_r; // @[fifo.scala 23:23]
  wire  wen = io_wr_valid & io_wr_ready; // @[fifo.scala 25:28]
  wire  ren = io_rd_valid & io_rd_ready; // @[fifo.scala 26:28]
  wire [4:0] _wptr_r_T_1 = wptr_r + 5'h1; // @[fifo.scala 37:32]
  wire [4:0] _rptr_r_T_1 = rptr_r + 5'h1; // @[fifo.scala 38:32]
  assign ram_rdat_MPORT_en = 1'h1;
  assign ram_rdat_MPORT_addr = rptr_r[3:0];
  assign ram_rdat_MPORT_data = ram[ram_rdat_MPORT_addr]; // @[fifo.scala 17:16]
  assign ram_MPORT_data = io_wr_bits;
  assign ram_MPORT_addr = wptr_r[3:0];
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_wr_valid & io_wr_ready;
  assign io_wr_ready = ~full; // @[fifo.scala 42:18]
  assign io_rd_valid = ~empty; // @[fifo.scala 40:18]
  assign io_rd_bits = ren ? ram_rdat_MPORT_data : 32'h0; // @[fifo.scala 35:17]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[fifo.scala 17:16]
    end
    if (reset) begin // @[fifo.scala 19:23]
      wptr_r <= 5'h0; // @[fifo.scala 19:23]
    end else if (wen) begin // @[fifo.scala 37:13]
      wptr_r <= _wptr_r_T_1; // @[fifo.scala 37:22]
    end
    if (reset) begin // @[fifo.scala 20:23]
      rptr_r <= 5'h0; // @[fifo.scala 20:23]
    end else if (ren) begin // @[fifo.scala 38:13]
      rptr_r <= _rptr_r_T_1; // @[fifo.scala 38:22]
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
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  wptr_r = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  rptr_r = _RAND_2[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
