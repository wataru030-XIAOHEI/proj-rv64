//================================================================
// file         : axi_ram_ctl
// description  : axi_ram_ctrl_interface
// author       : Wataru
// version      :
// date         : 2023-08-06
//================================================================
package libs
import bus.{axi_ar, axi_bundle, axi_io}
import chisel3._
import chisel3.util.{Fill, MuxCase}

trait axi_ram_ctl_parm {
  val AW :Int = 32
  val DW :Int = 32
  val LW :Int = 4
  val IDW:Int = 4
  val DP :Int = 3
}

class axi_ram_ctl_io extends Bundle with axi_ram_ctl_parm {
  val axi_mst = Flipped(new axi_io(UInt(32.W),AW,LW,IDW))

  //to sram
  val adr = Output(UInt(AW.W))
  val ren = Output(Bool())
  val wen = Output(Bool())
  val wstrb = Output(UInt(4.W))
  val wdat = Output(UInt(DW.W))
  val rdat = Input(UInt(DW.W))
  val rvld = Input(Bool())

}


abstract class axi_ram_ctl  extends Module with axi_ram_ctl_parm{
  val io = IO(new axi_ram_ctl_io)
  io := DontCare

}


class axi_ram_intf_ctl extends axi_ram_ctl {

  // ar channel
  val arack = io.axi_mst.ar_chl.ready && io.axi_mst.ar_chl.valid
  val axi_ar_fifo = Module(new axi_fifo(new axi_ar(AW,LW,IDW),DP))

  val ar_ready_r = RegInit(false.B)

  when(arack){
    ar_ready_r := false.B
  }.elsewhen(io.axi_mst.ar_chl.valid) {
    ar_ready_r := axi_ar_fifo.io.wr.ready
  }
  io.axi_mst.ar_chl.ready := ar_ready_r
  axi_ar_fifo.io.wr.valid := arack
  axi_ar_fifo.io.wr.bits  := io.axi_mst.ar_chl.bits


  val rdat_cnt_r = RegInit(0.U(LW.W))
  val rdat_cnt_in= Wire(UInt(LW.W))

  val wrap_mode     = axi_ar_fifo.io.rd.bits.arbusrt === "b10".U
  val incr_mode     = axi_ar_fifo.io.rd.bits.arbusrt === "b01".U
  val fixed_mode    = axi_ar_fifo.io.rd.bits.arbusrt === "b00".U
  val burst_mode = wrap_mode | incr_mode | fixed_mode

  val norm_radr = axi_ar_fifo.io.rd.bits.araddr
  val wrap_radr = axi_ar_fifo.io.rd.bits.araddr
  val burst_radr= axi_ar_fifo.io.rd.bits.araddr + rdat_cnt_r

  val rack  = io.axi_mst.r_chl.valid && io.axi_mst.r_chl.ready && io.axi_mst.r_chl.bits.rlast
  val rlast = rdat_cnt_r === axi_ar_fifo.io.rd.bits.arlen
  val rresp = Fill(2,rlast) & "b00".U
  val ren  = axi_ar_fifo.io.rd.valid

  when(rack){
    rdat_cnt_r := 0.U(LW.W)
  }.elsewhen(burst_mode) {
    rdat_cnt_r := rdat_cnt_in
  }

  rdat_cnt_in := Mux(io.axi_mst.r_chl.valid && io.axi_mst.r_chl.ready,
                      rdat_cnt_r + 1.U ,rdat_cnt_r)



  io.adr := MuxCase(norm_radr,Seq(
    fixed_mode -> norm_radr ,
    burst_mode -> burst_radr,
    wrap_mode  -> wrap_radr
  ))

  io.ren := ren
  io.axi_mst.r_chl.valid      := io.rvld
  io.axi_mst.r_chl.bits.rlast := rlast
  io.axi_mst.r_chl.bits.rid   := axi_ar_fifo.io.rd.bits.arid
  io.axi_mst.r_chl.bits.rdata := io.rdat
  io.axi_mst.r_chl.bits.rresp := rresp

  // release the axi_ar fifo
  axi_ar_fifo.io.rd.ready := rack

}
