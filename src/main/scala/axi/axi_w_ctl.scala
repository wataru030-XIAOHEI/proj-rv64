//================================================================
// file         : axi_w_ctl
// description  : axi_w_aw_channel_control
// author       : Wataru
// version      :
// date         : 2023-08-24
//================================================================
package axi
import bus._ 
import chisel3._ 
import chisel3.util._ 

class axi_w_ctl_io[T<:Data] ( gen:T ) extends Bundle with axi_parm {
  val axi_aw = Flipped(Decoupled(Output(new axi_aw(AW,LW,IDW))))
  val axi_w  = Flipped(Decoupled(Output(new axi_w(gen,IDW))))
  val axi_b  = Decoupled(Output(new axi_b(IDW)))

  val adr = Output(UInt(AW.W))
  val wen = Output(Bool())
  val wstrb = Output(UInt(WW.W))
  val wdat  = Output(gen)
  val free  = Input(Bool())
}


abstract class axi_w_ctl_base[T<:Data](gen:T) extends Module with axi_parm {
  val io = IO(new axi_w_ctl_io(gen))
} 

class axi_w_ctl[T<:Data](gen:T,DP:Int = 0 ) extends axi_w_ctl_base(gen) {
  assert(DP>0,"the Depth of axi_w_ctl's fifo must be bigger than 0 !")

  val awack = io.axi_aw.valid && io.axi_aw.ready
  val axi_aw_fifo = Module(new axi_fifo(new axi_aw(AW,LW,IDW),DP))
  val axi_b_fifo  = Module(new axi_fifo(Bool(),DP))

  val aw_ready_r = RegInit(false.B)

  //TODO : mayby can assign aw ready <> fifo_wr.ready ?
  when(awack){
    aw_ready_r := false.B
  }.elsewhen(io.axi_aw.valid){
    aw_ready_r := axi_aw_fifo.io.wr.ready
  }
  io.axi_aw.ready := aw_ready_r 

  axi_aw_fifo.io.wr.valid := awack 
  axi_aw_fifo.io.wr.bits  := io.axi_aw.bits 
  axi_b_fifo.io.wr.valid := awack 
  axi_b_fifo.io.wr.bits  := true.B

  //wdata cnt 
  val wdat_cnt_r = RegInit(0.U(LW.W))
  val wdat_cnt_in = Wire(UInt(LW.W))

  val wrap_mode = axi_aw_fifo.io.rd.bits.awbusrt === "b10".U
  val incr_mode = axi_aw_fifo.io.rd.bits.awbusrt === "b01".U 
  val fixed_mode = axi_aw_fifo.io.rd.bits.awbusrt === "b00".U 
  val burst_start = wrap_mode | incr_mode | fixed_mode 

  val norm_adr = axi_aw_fifo.io.rd.bits.awaddr 
  val wrap_adr = axi_aw_fifo.io.rd.bits.awaddr //TODO 
  val burst_adr = axi_aw_fifo.io.rd.bits.awaddr + wdat_cnt_r

  val wack = io.axi_w.valid && io.axi_w.ready && io.axi_w.bits.wlast
  val back = io.axi_b.valid && io.axi_b.ready 

  val bid_r    = RegInit(0.U(IDW.W))
  val bresp_r  = RegInit(0.U(2.W))
  val bvalid_r = RegInit(false.B)

  when(wack){
    bvalid_r := true.B
    bid_r    := axi_aw_fifo.io.rd.bits.awid
    bresp_r  := "b00".U
  }.elsewhen(back){
    bvalid_r := false.B
    bid_r    := 0.U 
    bresp_r  := 0.U
  }

  when(wack){
    wdat_cnt_r := 0.U 
  }.elsewhen(burst_start){
    wdat_cnt_r := wdat_cnt_in 
  }

  wdat_cnt_in := Mux(io.axi_w.valid && io.axi_w.ready,
                     wdat_cnt_r+1.U,wdat_cnt_r)


  //transfer 
  io.adr := MuxCase(norm_adr,Seq(
    fixed_mode -> norm_adr ,
    incr_mode  -> burst_adr ,
    wrap_mode  -> wrap_adr 
  ))    
  io.wen := io.axi_w.valid 
  io.wstrb := io.axi_w.bits.wstrb
  io.wdat := io.axi_w.bits.wdata
  io.axi_w.ready := io.free
  io.axi_b.valid := bvalid_r
  io.axi_b.bits.bid := bid_r
  io.axi_b.bits.bresp := bresp_r
  //release fifo 
  axi_aw_fifo.io.rd.ready := wack
  axi_b_fifo.io.rd.ready := back

}

