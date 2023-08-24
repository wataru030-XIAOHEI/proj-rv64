//================================================================
// file         : axi_r_ctl
// description  : axi_r_ar_channel_control
// author       : Wataru
// version      :
// date         : 2023-08-24
//================================================================
package axi 
import bus._ 
import chisel3._ 
import chisel3.util._ 


class axi_r_ctl_io[T<:Data] ( gen : T ) extends Bundle with axi_parm{
  val axi_ar = Flipped(Decoupled(Output(new axi_ar(AW,LW,IDW))))
  val axi_r  = Decoupled(Output(new axi_r(gen,IDW)))

  val adr = Output(UInt(AW.W))
  val ren = Output(Bool())
  val rdat = Input(gen)
  val rvld = Input(Bool())
}

abstract class axi_r_ctl_base[T<:Data](gen:T) extends Module with axi_parm{
  val io = IO(new axi_r_ctl_io(gen))
  io := DontCare 
}

class axi_r_ctl[T<:Data](gen:T,DP:Int = 0) extends axi_r_ctl_base(gen) {
  assert(DP>0,"the Depth of axi_r_ctl's fifo must be bigger than 0 !")

  val arack = io.axi_ar.valid && io.axi_ar.ready
  val axi_ar_fifo = Module(new axi_fifo(new axi_ar(AW,LW,IDW),DP))
  val ar_ready_r = RegInit(false.B)

  // TODO, maybe can assign ar_ready <> fifo_wr_ready ?
  when(arack){
    ar_ready_r := false.B 
  }.elsewhen(io.axi_ar.valid){
    ar_ready_r := axi_ar_fifo.io.wr.ready 
  }
  io.axi_ar.ready := ar_ready_r

  axi_ar_fifo.io.wr.valid := arack 
  axi_ar_fifo.io.wr.bits  := io.axi_ar.bits

  //rdata cnt 
  val rdat_cnt_r = RegInit(0.U(LW.W))
  val rdat_cnt_in = Wire(UInt(LW.W))

  val wrap_mode = axi_ar_fifo.io.rd.bits.arbusrt === "b10".U
  val incr_mode = axi_ar_fifo.io.rd.bits.arbusrt === "b01".U 
  val fixed_mode = axi_ar_fifo.io.rd.bits.arbusrt === "b00".U 
  val burst_start = wrap_mode | incr_mode | fixed_mode 


  val norm_adr = axi_ar_fifo.io.rd.bits.araddr 
  val wrap_adr = axi_ar_fifo.io.rd.bits.araddr //TODO 
  val burst_adr = axi_ar_fifo.io.rd.bits.araddr + rdat_cnt_r

  val rack = io.axi_r.valid && io.axi_r.ready & io.axi_r.bits.rlast
  val rlast = rdat_cnt_r === axi_ar_fifo.io.rd.bits.arlen
  val rresp = Fill(2,rlast) & "b00".U 
  val ren   = axi_ar_fifo.io.rd.valid 

  when(rack){
    rdat_cnt_r := 0.U
  }.elsewhen(burst_start){
    rdat_cnt_r := rdat_cnt_in 
  }

  rdat_cnt_in := Mux(io.axi_r.valid && io.axi_r.ready,
                     rdat_cnt_r+1.U,rdat_cnt_r)

  // transfer to output 
  io.adr := MuxCase(norm_adr,Seq(
    fixed_mode -> norm_adr ,
    incr_mode -> burst_adr ,
    wrap_mode  -> wrap_adr
  ))

  io.ren := ren
  io.axi_r.valid := io.rvld 
  io.axi_r.bits.rlast := Mux(io.axi_r.valid,rlast ,0.U)
  io.axi_r.bits.rid   := Mux(io.axi_r.valid,axi_ar_fifo.io.rd.bits.arid ,0.U)
  io.axi_r.bits.rdata := Mux(io.axi_r.valid,io.rdat ,0.U)
  io.axi_r.bits.rresp := Mux(io.axi_r.valid,rresp ,0.U)

  //release the fifo 
  axi_ar_fifo.io.rd.ready := rack

}