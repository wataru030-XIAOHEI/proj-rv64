module axi_gen_test(
  input         clock,
  input         reset,
  output        axi_mst_ar_chl_ready,
  input         axi_mst_ar_chl_valid,
  input  [3:0]  axi_mst_ar_chl_bits_arid,
  input  [31:0] axi_mst_ar_chl_bits_araddr,
  input  [2:0]  axi_mst_ar_chl_bits_arsize,
  input  [3:0]  axi_mst_ar_chl_bits_arlen,
  input  [1:0]  axi_mst_ar_chl_bits_arbusrt,
  input  [1:0]  axi_mst_ar_chl_bits_arlock,
  input  [1:0]  axi_mst_ar_chl_bits_arcache,
  input  [1:0]  axi_mst_ar_chl_bits_arprot,
  input         axi_mst_r_chl_ready,
  output        axi_mst_r_chl_valid,
  output [31:0] axi_mst_r_chl_bits_rdata,
  output [3:0]  axi_mst_r_chl_bits_rid,
  output [1:0]  axi_mst_r_chl_bits_rresp,
  output        axi_mst_r_chl_bits_rlast,
  output        axi_mst_aw_chl_ready,
  input         axi_mst_aw_chl_valid,
  input  [3:0]  axi_mst_aw_chl_bits_awid,
  input  [31:0] axi_mst_aw_chl_bits_awaddr,
  input  [2:0]  axi_mst_aw_chl_bits_awsize,
  input  [3:0]  axi_mst_aw_chl_bits_awlen,
  input  [1:0]  axi_mst_aw_chl_bits_awbusrt,
  input  [1:0]  axi_mst_aw_chl_bits_awlock,
  input  [1:0]  axi_mst_aw_chl_bits_awcache,
  input  [1:0]  axi_mst_aw_chl_bits_awprot,
  output        axi_mst_w_chl_ready,
  input         axi_mst_w_chl_valid,
  input  [31:0] axi_mst_w_chl_bits_wdata,
  input  [3:0]  axi_mst_w_chl_bits_wid,
  input  [3:0]  axi_mst_w_chl_bits_wstrb,
  input         axi_mst_w_chl_bits_wlast,
  input         axi_mst_b_chl_ready,
  output        axi_mst_b_chl_valid,
  output [3:0]  axi_mst_b_chl_bits_bid,
  output [1:0]  axi_mst_b_chl_bits_bresp,
  input         axi_slv_ar_chl_ready,
  output        axi_slv_ar_chl_valid,
  output [3:0]  axi_slv_ar_chl_bits_arid,
  output [31:0] axi_slv_ar_chl_bits_araddr,
  output [2:0]  axi_slv_ar_chl_bits_arsize,
  output [3:0]  axi_slv_ar_chl_bits_arlen,
  output [1:0]  axi_slv_ar_chl_bits_arbusrt,
  output [1:0]  axi_slv_ar_chl_bits_arlock,
  output [1:0]  axi_slv_ar_chl_bits_arcache,
  output [1:0]  axi_slv_ar_chl_bits_arprot,
  output        axi_slv_r_chl_ready,
  input         axi_slv_r_chl_valid,
  input  [31:0] axi_slv_r_chl_bits_rdata,
  input  [3:0]  axi_slv_r_chl_bits_rid,
  input  [1:0]  axi_slv_r_chl_bits_rresp,
  input         axi_slv_r_chl_bits_rlast,
  input         axi_slv_aw_chl_ready,
  output        axi_slv_aw_chl_valid,
  output [3:0]  axi_slv_aw_chl_bits_awid,
  output [31:0] axi_slv_aw_chl_bits_awaddr,
  output [2:0]  axi_slv_aw_chl_bits_awsize,
  output [3:0]  axi_slv_aw_chl_bits_awlen,
  output [1:0]  axi_slv_aw_chl_bits_awbusrt,
  output [1:0]  axi_slv_aw_chl_bits_awlock,
  output [1:0]  axi_slv_aw_chl_bits_awcache,
  output [1:0]  axi_slv_aw_chl_bits_awprot,
  input         axi_slv_w_chl_ready,
  output        axi_slv_w_chl_valid,
  output [31:0] axi_slv_w_chl_bits_wdata,
  output [3:0]  axi_slv_w_chl_bits_wid,
  output [3:0]  axi_slv_w_chl_bits_wstrb,
  output        axi_slv_w_chl_bits_wlast,
  output        axi_slv_b_chl_ready,
  input         axi_slv_b_chl_valid,
  input  [3:0]  axi_slv_b_chl_bits_bid,
  input  [1:0]  axi_slv_b_chl_bits_bresp
);
  wire  temp_axi_bundle_ar_chl_ready = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_ar_chl_valid = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [3:0] temp_axi_bundle_ar_chl_bits_arid = 4'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [31:0] temp_axi_bundle_ar_chl_bits_araddr = 32'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [2:0] temp_axi_bundle_ar_chl_bits_arsize = 3'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [3:0] temp_axi_bundle_ar_chl_bits_arlen = 4'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_ar_chl_bits_arbusrt = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_ar_chl_bits_arlock = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_ar_chl_bits_arcache = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_ar_chl_bits_arprot = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_r_chl_ready = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_r_chl_valid = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [31:0] temp_axi_bundle_r_chl_bits_rdata = 32'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [3:0] temp_axi_bundle_r_chl_bits_rid = 4'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_r_chl_bits_rresp = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_r_chl_bits_rlast = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_aw_chl_ready = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_aw_chl_valid = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [3:0] temp_axi_bundle_aw_chl_bits_awid = 4'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [31:0] temp_axi_bundle_aw_chl_bits_awaddr = 32'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [2:0] temp_axi_bundle_aw_chl_bits_awsize = 3'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [3:0] temp_axi_bundle_aw_chl_bits_awlen = 4'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_aw_chl_bits_awbusrt = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_aw_chl_bits_awlock = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_aw_chl_bits_awcache = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_aw_chl_bits_awprot = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_w_chl_ready = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_w_chl_valid = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [31:0] temp_axi_bundle_w_chl_bits_wdata = 32'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [3:0] temp_axi_bundle_w_chl_bits_wid = 4'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [3:0] temp_axi_bundle_w_chl_bits_wstrb = 4'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_w_chl_bits_wlast = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_b_chl_ready = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire  temp_axi_bundle_b_chl_valid = 1'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [3:0] temp_axi_bundle_b_chl_bits_bid = 4'h0; // @[axi_gen_test.scala 18:{46,46}]
  wire [1:0] temp_axi_bundle_b_chl_bits_bresp = 2'h0; // @[axi_gen_test.scala 18:{46,46}]
  assign axi_mst_ar_chl_ready = axi_slv_ar_chl_ready; // @[axi_gen_test.scala 23:11]
  assign axi_mst_r_chl_valid = axi_slv_r_chl_valid; // @[axi_gen_test.scala 23:11]
  assign axi_mst_r_chl_bits_rdata = axi_slv_r_chl_bits_rdata; // @[axi_gen_test.scala 23:11]
  assign axi_mst_r_chl_bits_rid = axi_slv_r_chl_bits_rid; // @[axi_gen_test.scala 23:11]
  assign axi_mst_r_chl_bits_rresp = axi_slv_r_chl_bits_rresp; // @[axi_gen_test.scala 23:11]
  assign axi_mst_r_chl_bits_rlast = axi_slv_r_chl_bits_rlast; // @[axi_gen_test.scala 23:11]
  assign axi_mst_aw_chl_ready = axi_slv_aw_chl_ready; // @[axi_gen_test.scala 23:11]
  assign axi_mst_w_chl_ready = axi_slv_w_chl_ready; // @[axi_gen_test.scala 23:11]
  assign axi_mst_b_chl_valid = axi_slv_b_chl_valid; // @[axi_gen_test.scala 23:11]
  assign axi_mst_b_chl_bits_bid = axi_slv_b_chl_bits_bid; // @[axi_gen_test.scala 23:11]
  assign axi_mst_b_chl_bits_bresp = axi_slv_b_chl_bits_bresp; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_valid = axi_mst_ar_chl_valid; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_bits_arid = axi_mst_ar_chl_bits_arid; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_bits_araddr = axi_mst_ar_chl_bits_araddr; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_bits_arsize = axi_mst_ar_chl_bits_arsize; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_bits_arlen = axi_mst_ar_chl_bits_arlen; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_bits_arbusrt = axi_mst_ar_chl_bits_arbusrt; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_bits_arlock = axi_mst_ar_chl_bits_arlock; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_bits_arcache = axi_mst_ar_chl_bits_arcache; // @[axi_gen_test.scala 23:11]
  assign axi_slv_ar_chl_bits_arprot = axi_mst_ar_chl_bits_arprot; // @[axi_gen_test.scala 23:11]
  assign axi_slv_r_chl_ready = axi_mst_r_chl_ready; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_valid = axi_mst_aw_chl_valid; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_bits_awid = axi_mst_aw_chl_bits_awid; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_bits_awaddr = axi_mst_aw_chl_bits_awaddr; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_bits_awsize = axi_mst_aw_chl_bits_awsize; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_bits_awlen = axi_mst_aw_chl_bits_awlen; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_bits_awbusrt = axi_mst_aw_chl_bits_awbusrt; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_bits_awlock = axi_mst_aw_chl_bits_awlock; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_bits_awcache = axi_mst_aw_chl_bits_awcache; // @[axi_gen_test.scala 23:11]
  assign axi_slv_aw_chl_bits_awprot = axi_mst_aw_chl_bits_awprot; // @[axi_gen_test.scala 23:11]
  assign axi_slv_w_chl_valid = axi_mst_w_chl_valid; // @[axi_gen_test.scala 23:11]
  assign axi_slv_w_chl_bits_wdata = axi_mst_w_chl_bits_wdata; // @[axi_gen_test.scala 23:11]
  assign axi_slv_w_chl_bits_wid = axi_mst_w_chl_bits_wid; // @[axi_gen_test.scala 23:11]
  assign axi_slv_w_chl_bits_wstrb = axi_mst_w_chl_bits_wstrb; // @[axi_gen_test.scala 23:11]
  assign axi_slv_w_chl_bits_wlast = axi_mst_w_chl_bits_wlast; // @[axi_gen_test.scala 23:11]
  assign axi_slv_b_chl_ready = axi_mst_b_chl_ready; // @[axi_gen_test.scala 23:11]
endmodule
