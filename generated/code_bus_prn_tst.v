module code_bus_prn_tst(
  input         clock,
  input         reset,
  input         io_rreq,
  input         io_wreq,
  input  [3:0]  io_radr,
  input  [3:0]  io_wadr,
  input  [31:0] io_wdat,
  output        io_wok,
  output [31:0] io_rdat,
  output        io_rok
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] con_reg_0; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_1; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_2; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_3; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_4; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_5; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_6; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_7; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_8; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_9; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_10; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_11; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_12; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_13; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_14; // @[code_bus_prn_tst.scala 10:26]
  reg [31:0] con_reg_15; // @[code_bus_prn_tst.scala 10:26]
  wire  con_re_15 = io_radr == 4'hf & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T = con_re_15 ? con_reg_15 : 32'h0; // @[Mux.scala 101:16]
  wire  con_re_14 = io_radr == 4'he & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_1 = con_re_14 ? con_reg_14 : _io_rdat_T; // @[Mux.scala 101:16]
  wire  con_re_13 = io_radr == 4'hd & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_2 = con_re_13 ? con_reg_13 : _io_rdat_T_1; // @[Mux.scala 101:16]
  wire  con_re_12 = io_radr == 4'hc & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_3 = con_re_12 ? con_reg_12 : _io_rdat_T_2; // @[Mux.scala 101:16]
  wire  con_re_11 = io_radr == 4'hb & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_4 = con_re_11 ? con_reg_11 : _io_rdat_T_3; // @[Mux.scala 101:16]
  wire  con_re_10 = io_radr == 4'ha & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_5 = con_re_10 ? con_reg_10 : _io_rdat_T_4; // @[Mux.scala 101:16]
  wire  con_re_9 = io_radr == 4'h9 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_6 = con_re_9 ? con_reg_9 : _io_rdat_T_5; // @[Mux.scala 101:16]
  wire  con_re_8 = io_radr == 4'h8 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_7 = con_re_8 ? con_reg_8 : _io_rdat_T_6; // @[Mux.scala 101:16]
  wire  con_re_7 = io_radr == 4'h7 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_8 = con_re_7 ? con_reg_7 : _io_rdat_T_7; // @[Mux.scala 101:16]
  wire  con_re_6 = io_radr == 4'h6 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_9 = con_re_6 ? con_reg_6 : _io_rdat_T_8; // @[Mux.scala 101:16]
  wire  con_re_5 = io_radr == 4'h5 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_10 = con_re_5 ? con_reg_5 : _io_rdat_T_9; // @[Mux.scala 101:16]
  wire  con_re_4 = io_radr == 4'h4 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_11 = con_re_4 ? con_reg_4 : _io_rdat_T_10; // @[Mux.scala 101:16]
  wire  con_re_3 = io_radr == 4'h3 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_12 = con_re_3 ? con_reg_3 : _io_rdat_T_11; // @[Mux.scala 101:16]
  wire  con_re_2 = io_radr == 4'h2 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_13 = con_re_2 ? con_reg_2 : _io_rdat_T_12; // @[Mux.scala 101:16]
  wire  con_re_1 = io_radr == 4'h1 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire [31:0] _io_rdat_T_14 = con_re_1 ? con_reg_1 : _io_rdat_T_13; // @[Mux.scala 101:16]
  wire  con_re_0 = io_radr == 4'h0 & io_rreq; // @[code_bus_prn_tst.scala 25:40]
  wire  con_we_0 = io_wadr == 4'h0 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_1 = io_wadr == 4'h1 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_2 = io_wadr == 4'h2 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_3 = io_wadr == 4'h3 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_4 = io_wadr == 4'h4 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_5 = io_wadr == 4'h5 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_6 = io_wadr == 4'h6 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_7 = io_wadr == 4'h7 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_8 = io_wadr == 4'h8 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_9 = io_wadr == 4'h9 & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_10 = io_wadr == 4'ha & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_11 = io_wadr == 4'hb & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_12 = io_wadr == 4'hc & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_13 = io_wadr == 4'hd & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_14 = io_wadr == 4'he & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  con_we_15 = io_wadr == 4'hf & io_wreq; // @[code_bus_prn_tst.scala 26:40]
  wire  _wv_T = io_wok & io_wreq; // @[core_bus.scala 53:25]
  wire [6:0] wv = io_wok & io_wreq ? 7'h57 : 7'h2d; // @[core_bus.scala 53:21]
  wire [3:0] wa = _wv_T ? io_wadr : 4'h0; // @[core_bus.scala 54:21]
  wire [31:0] wd = _wv_T ? io_wdat : 32'h0; // @[core_bus.scala 55:21]
  assign io_wok = con_we_0 | con_we_1 | (con_we_2 | con_we_3) | (con_we_4 | con_we_5 | (con_we_6 | con_we_7)) | (
    con_we_8 | con_we_9 | (con_we_10 | con_we_11) | (con_we_12 | con_we_13 | (con_we_14 | con_we_15))); // @[code_bus_prn_tst.scala 22:34]
  assign io_rdat = con_re_0 ? con_reg_0 : _io_rdat_T_14; // @[Mux.scala 101:16]
  assign io_rok = con_re_0 | con_re_1 | (con_re_2 | con_re_3) | (con_re_4 | con_re_5 | (con_re_6 | con_re_7)) | (
    con_re_8 | con_re_9 | (con_re_10 | con_re_11) | (con_re_12 | con_re_13 | (con_re_14 | con_re_15))); // @[code_bus_prn_tst.scala 21:34]
  always @(posedge clock) begin
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_0 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_0) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_0 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_1 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_1) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_1 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_2 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_2) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_2 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_3 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_3) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_3 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_4 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_4) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_4 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_5 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_5) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_5 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_6 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_6) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_6 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_7 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_7) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_7 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_8 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_8) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_8 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_9 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_9) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_9 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_10 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_10) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_10 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_11 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_11) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_11 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_12 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_12) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_12 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_13 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_13) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_13 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_14 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_14) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_14 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    if (reset) begin // @[code_bus_prn_tst.scala 10:26]
      con_reg_15 <= 32'h0; // @[code_bus_prn_tst.scala 10:26]
    end else if (con_we_15) begin // @[code_bus_prn_tst.scala 28:25]
      con_reg_15 <= io_wdat; // @[code_bus_prn_tst.scala 28:37]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"%c : 0x%x => 0x%d \n",wv,wa,wd); // @[code_bus_prn_tst.scala 31:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
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
  con_reg_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  con_reg_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  con_reg_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  con_reg_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  con_reg_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  con_reg_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  con_reg_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  con_reg_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  con_reg_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  con_reg_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  con_reg_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  con_reg_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  con_reg_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  con_reg_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  con_reg_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  con_reg_15 = _RAND_15[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
