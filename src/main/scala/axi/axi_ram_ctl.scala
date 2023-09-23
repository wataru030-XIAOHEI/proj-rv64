//================================================================
// file         : axi_ram_ctl
// description  : axi_ram_ctrl_interface
// author       : Wataru
// version      :
// date         : 2023-08-06
//================================================================
package axi
import bus._
import chisel3._
import chisel3.util.{Fill, MuxCase}
import bus.axi_chl_param
import bus.axi_channel_io


class axi_ram_ctl_io (implicit p: axi_chl_param)extends Bundle {
  val axi_mst = Flipped(new axi_channel_io()(p))
  //to sram
  val adr = Output(UInt(p.AW.W))
  val ren = Output(Bool())
  val wen = Output(Bool())
  val wstrb = Output(UInt(p.WW.W))
  val wdat  = Output(UInt(p.DW.W))
  val rdat = Input(UInt(p.DW.W))
  val rvld = Input(Bool())
  val free = Input(Bool())

}


abstract class axi_ram_ctl (implicit p : axi_chl_param) extends Module{
  val io = IO(new axi_ram_ctl_io()(p))
  io := DontCare

}


class axi_ram_intf_ctl(DP:Int)(implicit p :axi_chl_param)extends axi_ram_ctl()(p) {
  val axi_r_ctl = Module(new axi_r_ctl(DP)(p))
  val axi_w_ctl = Module(new axi_w_ctl(DP)(p))
  axi_r_ctl.io.axi_ar <> io.axi_mst.ar
  axi_r_ctl.io.axi_r  <> io.axi_mst.r 
  axi_w_ctl.io.axi_aw <> io.axi_mst.aw
  axi_w_ctl.io.axi_w  <> io.axi_mst.w
  axi_w_ctl.io.axi_b  <> io.axi_mst.b
  

  io.adr := Mux(axi_r_ctl.io.adr.en ,axi_r_ctl.io.adr.adr,
            Mux(axi_w_ctl.io.adr.en ,axi_w_ctl.io.adr.adr,0.U(p.AW.W)))
  io.ren := axi_r_ctl.io.adr.en 
  io.wen := axi_w_ctl.io.adr.en
  io.wstrb := axi_w_ctl.io.dat.bits.strb
  io.wdat := axi_w_ctl.io.dat.bits.dat
  axi_w_ctl.io.free := io.free
  axi_r_ctl.io.dat.valid := io.rvld
  axi_r_ctl.io.dat.bits.dat := io.rdat
  axi_r_ctl.io.dat.bits.strb := DontCare

  val debug_arack = io.axi_mst.ar.valid && io.axi_mst.ar.ready
  val debug_rack  = io.axi_mst.r.valid && io.axi_mst.r.ready 
  val debug_awack = io.axi_mst.aw.valid && io.axi_mst.aw.ready 
  val debug_wack  = io.axi_mst.w.valid && io.axi_mst.w.ready
  val debug_back  = io.axi_mst.b.valid && io.axi_mst.b.ready
}
