module snyc_sram_model(
  input         clock,
  input         reset,
  input  [7:0]  io_adr,
  input         io_cen,
  input         io_wen,
  input  [3:0]  io_wstrb,
  input  [31:0] io_d,
  output [31:0] io_q
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:255]; // @[sram_model.scala 96:18]
  wire  mem_rdat_dly_MPORT_en; // @[sram_model.scala 96:18]
  wire [7:0] mem_rdat_dly_MPORT_addr; // @[sram_model.scala 96:18]
  wire [31:0] mem_rdat_dly_MPORT_data; // @[sram_model.scala 96:18]
  wire  mem_wr_rd_pre_en; // @[sram_model.scala 96:18]
  wire [7:0] mem_wr_rd_pre_addr; // @[sram_model.scala 96:18]
  wire [31:0] mem_wr_rd_pre_data; // @[sram_model.scala 96:18]
  wire [31:0] mem_MPORT_data; // @[sram_model.scala 96:18]
  wire [7:0] mem_MPORT_addr; // @[sram_model.scala 96:18]
  wire  mem_MPORT_mask; // @[sram_model.scala 96:18]
  wire  mem_MPORT_en; // @[sram_model.scala 96:18]
  wire  _re_T = ~io_cen; // @[sram_model.scala 101:15]
  wire  re = ~io_cen & io_wen; // @[sram_model.scala 101:23]
  wire  _we_T_1 = ~io_wen; // @[sram_model.scala 102:25]
  wire  we = _re_T & ~io_wen; // @[sram_model.scala 102:23]
  reg [31:0] rdat_dly; // @[sram_model.scala 105:27]
  wire [7:0] _wr_pre_T_4 = we & io_wstrb[3] ? io_d[31:24] : mem_wr_rd_pre_data[31:24]; // @[sram_model.scala 115:12]
  wire [7:0] _wr_pre_T_9 = we & io_wstrb[2] ? io_d[23:16] : mem_wr_rd_pre_data[23:16]; // @[sram_model.scala 116:12]
  wire [7:0] _wr_pre_T_14 = we & io_wstrb[1] ? io_d[15:8] : mem_wr_rd_pre_data[15:8]; // @[sram_model.scala 117:12]
  wire [7:0] _wr_pre_T_19 = we & io_wstrb[0] ? io_d[7:0] : mem_wr_rd_pre_data[7:0]; // @[sram_model.scala 118:12]
  wire [15:0] wr_pre_lo = {_wr_pre_T_14,_wr_pre_T_19}; // @[Cat.scala 33:92]
  wire [15:0] wr_pre_hi = {_wr_pre_T_4,_wr_pre_T_9}; // @[Cat.scala 33:92]
  wire  _T_1 = ~reset; // @[sram_model.scala 130:19]
  assign mem_rdat_dly_MPORT_en = _re_T & io_wen;
  assign mem_rdat_dly_MPORT_addr = io_adr;
  assign mem_rdat_dly_MPORT_data = mem[mem_rdat_dly_MPORT_addr]; // @[sram_model.scala 96:18]
  assign mem_wr_rd_pre_en = 1'h1;
  assign mem_wr_rd_pre_addr = io_adr;
  assign mem_wr_rd_pre_data = mem[mem_wr_rd_pre_addr]; // @[sram_model.scala 96:18]
  assign mem_MPORT_data = {wr_pre_hi,wr_pre_lo};
  assign mem_MPORT_addr = io_adr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = _re_T & _we_T_1;
  assign io_q = rdat_dly; // @[sram_model.scala 109:10]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[sram_model.scala 96:18]
    end
    if (reset) begin // @[sram_model.scala 105:27]
      rdat_dly <= 32'h0; // @[sram_model.scala 105:27]
    end else if (re) begin // @[sram_model.scala 106:15]
      rdat_dly <= mem_rdat_dly_MPORT_data; // @[sram_model.scala 106:26]
    end else begin
      rdat_dly <= 32'h0; // @[sram_model.scala 107:26]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (re & ~reset) begin
          $fwrite(32'h80000002,"rd mem[0x%x] => 0x%x\n",io_adr,io_q); // @[sram_model.scala 130:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (we & _T_1) begin
          $fwrite(32'h80000002,"wr mem[0x%x] := 0x%x",io_adr,io_d); // @[sram_model.scala 133:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (we & _T_1) begin
          $fwrite(32'h80000002,"  wstrb : 0x%x\n",io_wstrb); // @[sram_model.scala 134:19]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  rdat_dly = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module sram_model(
  input         clock,
  input         reset,
  input  [7:0]  io_adr,
  input         io_cen,
  input         io_wen,
  input  [3:0]  io_wstrb,
  input  [31:0] io_d,
  output [31:0] io_q
);
  wire  mem_clock; // @[sram_model.scala 157:25]
  wire  mem_reset; // @[sram_model.scala 157:25]
  wire [7:0] mem_io_adr; // @[sram_model.scala 157:25]
  wire  mem_io_cen; // @[sram_model.scala 157:25]
  wire  mem_io_wen; // @[sram_model.scala 157:25]
  wire [3:0] mem_io_wstrb; // @[sram_model.scala 157:25]
  wire [31:0] mem_io_d; // @[sram_model.scala 157:25]
  wire [31:0] mem_io_q; // @[sram_model.scala 157:25]
  snyc_sram_model mem ( // @[sram_model.scala 157:25]
    .clock(mem_clock),
    .reset(mem_reset),
    .io_adr(mem_io_adr),
    .io_cen(mem_io_cen),
    .io_wen(mem_io_wen),
    .io_wstrb(mem_io_wstrb),
    .io_d(mem_io_d),
    .io_q(mem_io_q)
  );
  assign io_q = mem_io_q; // @[sram_model.scala 158:16]
  assign mem_clock = clock;
  assign mem_reset = reset;
  assign mem_io_adr = io_adr; // @[sram_model.scala 158:16]
  assign mem_io_cen = io_cen; // @[sram_model.scala 158:16]
  assign mem_io_wen = io_wen; // @[sram_model.scala 158:16]
  assign mem_io_wstrb = io_wstrb; // @[sram_model.scala 158:16]
  assign mem_io_d = io_d; // @[sram_model.scala 158:16]
endmodule
