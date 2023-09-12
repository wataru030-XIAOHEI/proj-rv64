//================================================================
// file         : axi_ram_ctl
// description  : axi_ram_ctrl_interface
// author       : Wataru
// version      :
// date         : 2023-08-06
//================================================================
package axi
import bus.{axi_ar, axi_bundle, axi_io}
import chisel3._
import chisel3.util.{Fill, MuxCase}


class axi_ram_ctl_io extends Bundle with axi_parm {
  val axi_mst = Flipped(new axi_io(UInt(32.W),AW,LW,IDW))

  //to sram
  val adr = Output(UInt(AW.W))
  val ren = Output(Bool())
  val wen = Output(Bool())
  val wstrb = Output(UInt(WW.W))
  val wdat  = Output(UInt(DW.W))
  val rdat = Input(UInt(DW.W))
  val rvld = Input(Bool())
  val free = Input(Bool())

}


abstract class axi_ram_ctl  extends Module with axi_parm{
  val io = IO(new axi_ram_ctl_io)
  io := DontCare

}


class axi_ram_intf_ctl extends axi_ram_ctl {
  val axi_r_ctl = Module(new axi_r_ctl(UInt(DW.W),3))
  val axi_w_ctl = Module(new axi_w_ctl(UInt(DW.W),3))
  axi_r_ctl.io.axi_ar <> io.axi_mst.ar_chl
  axi_r_ctl.io.axi_r  <> io.axi_mst.r_chl 
  axi_w_ctl.io.axi_aw <> io.axi_mst.aw_chl
  axi_w_ctl.io.axi_w  <> io.axi_mst.w_chl
  axi_w_ctl.io.axi_b  <> io.axi_mst.b_chl
  


  io.adr := Mux(axi_r_ctl.io.ren ,axi_r_ctl.io.adr,
            Mux(axi_w_ctl.io.wen ,axi_w_ctl.io.adr,0.U(AW.W)))
  io.ren := axi_r_ctl.io.ren 
  io.wen := axi_w_ctl.io.wen
  io.wstrb := axi_w_ctl.io.wstrb
  io.wdat := axi_w_ctl.io.wdat
  axi_w_ctl.io.free := io.free
  axi_r_ctl.io.rvld := io.rvld
  axi_r_ctl.io.rdat := io.rdat


  val debug_arack = io.axi_mst.ar_chl.valid && io.axi_mst.ar_chl.ready
  val debug_rack  = io.axi_mst.r_chl.valid && io.axi_mst.r_chl.ready 
  val debug_awack = io.axi_mst.aw_chl.valid && io.axi_mst.aw_chl.ready 
  val debug_wack  = io.axi_mst.w_chl.valid && io.axi_mst.w_chl.ready
  val debug_back  = io.axi_mst.b_chl.valid && io.axi_mst.b_chl.ready
}
