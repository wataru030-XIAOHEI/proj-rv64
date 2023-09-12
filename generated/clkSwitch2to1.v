module clkSwitch2to1(
  input   clock,
  input   reset,
  input   io_clkin_0,
  input   io_clkin_1,
  input   io_clksel,
  output  io_clko
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  sel_clk1 = ~io_clksel; // @[clk.scala 48:28]
  reg [1:0] sel_clk0_r; // @[clk.scala 59:29]
  wire  _T_1 = ~io_clkin_1; // @[clk.scala 78:32]
  reg [1:0] sel_clk1_neg_r; // @[clk.scala 79:33]
  wire  _sel_clk0_r_T_4 = io_clksel & ~sel_clk1_neg_r[1]; // @[clk.scala 60:54]
  wire [1:0] _sel_clk0_r_T_5 = {sel_clk0_r[0],_sel_clk0_r_T_4}; // @[Cat.scala 33:92]
  wire  _T = ~io_clkin_0; // @[clk.scala 64:32]
  reg [1:0] sel_clk0_neg_r; // @[clk.scala 65:33]
  wire [1:0] _sel_clk0_neg_r_T_2 = {sel_clk0_neg_r[0],sel_clk0_r[1]}; // @[Cat.scala 33:92]
  reg [1:0] sel_clk1_r; // @[clk.scala 72:29]
  wire  _sel_clk1_r_T_4 = sel_clk1 & ~sel_clk0_neg_r[1]; // @[clk.scala 73:54]
  wire [1:0] _sel_clk1_r_T_5 = {sel_clk1_r[0],_sel_clk1_r_T_4}; // @[Cat.scala 33:92]
  wire [1:0] _sel_clk1_neg_r_T_2 = {sel_clk1_neg_r[0],sel_clk1_r[1]}; // @[Cat.scala 33:92]
  wire  clk_gate_0 = io_clkin_0 & sel_clk0_neg_r[1]; // @[clk.scala 86:37]
  wire  clk_gate_1 = io_clkin_1 & sel_clk1_neg_r[1]; // @[clk.scala 87:37]
  wire [1:0] _io_clko_T = {clk_gate_1,clk_gate_0}; // @[clk.scala 89:23]
  assign io_clko = |_io_clko_T; // @[clk.scala 89:34]
  always @(posedge io_clkin_0) begin
    if (reset) begin // @[clk.scala 59:29]
      sel_clk0_r <= 2'h3; // @[clk.scala 59:29]
    end else begin
      sel_clk0_r <= _sel_clk0_r_T_5; // @[clk.scala 60:16]
    end
  end
  always @(posedge _T_1) begin
    if (reset) begin // @[clk.scala 79:33]
      sel_clk1_neg_r <= 2'h0; // @[clk.scala 79:33]
    end else begin
      sel_clk1_neg_r <= _sel_clk1_neg_r_T_2; // @[clk.scala 80:20]
    end
  end
  always @(posedge _T) begin
    if (reset) begin // @[clk.scala 65:33]
      sel_clk0_neg_r <= 2'h0; // @[clk.scala 65:33]
    end else begin
      sel_clk0_neg_r <= _sel_clk0_neg_r_T_2; // @[clk.scala 66:20]
    end
  end
  always @(posedge io_clkin_1) begin
    if (reset) begin // @[clk.scala 72:29]
      sel_clk1_r <= 2'h0; // @[clk.scala 72:29]
    end else begin
      sel_clk1_r <= _sel_clk1_r_T_5; // @[clk.scala 73:16]
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
  sel_clk0_r = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  sel_clk1_neg_r = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  sel_clk0_neg_r = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  sel_clk1_r = _RAND_3[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
