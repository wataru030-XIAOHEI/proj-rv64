module BindsTo_0_freelist(
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

                      endmodule

bind freelist BindsTo_0_freelist BindsTo_0_freelist_Inst(.*);