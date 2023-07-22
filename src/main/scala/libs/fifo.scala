//================================================================
// file         : fifo
// description  : fifo , normal fifo and chisel3-API fifo
// author       : Lin Pei Run
// version      :
// date         : 2023-07-17
//================================================================
package libs


import chisel3._
import chisel3.util._

class fifo_io[T <: Data](gen:T) extends Bundle {
  // valid ,ready and data(bits) interface
  val wr    = Flipped(Decoupled(gen))
  val rd    = Decoupled(gen)
}

abstract class fifo_base[T<:Data](gen:T) extends Module {
  val io = IO(new fifo_io(gen))
}

class fifo[T<:Data](gen:T,DP:Int = 0 ) extends fifo_base(gen) {

  //check depth neq 0
  assert(DP > 0, "fifo depth is 0 ! please modify this fifo's depth !")

  val ptr_wd = log2Ceil(DP)+1

  val ram = Mem(DP,gen)       // registers array  ram[DP][32]

  val wptr_r = RegInit(0.U(ptr_wd.W))
  val rptr_r = RegInit(0.U(ptr_wd.W))

  val full   = wptr_r.head(1) =/= rptr_r.head(1) && wptr_r.tail(1) === rptr_r.tail(1)
  val empty  = wptr_r === rptr_r

  val wen    = io.wr.valid && io.wr.ready
  val ren    = io.rd.valid && io.rd.ready

  val w_idx  = wptr_r.tail(1)
  val r_idx  = rptr_r.tail(1)


  when(wen){ ram.write(w_idx,io.wr.bits) }
  //pointer update
  when(wen) { wptr_r := wptr_r + 1.U(ptr_wd.W) }
  when(ren) { rptr_r := rptr_r + 1.U(ptr_wd.W) }

  val rdat = Mux(ren , ram.read(r_idx),0.U.asTypeOf(gen))
  io.rd.valid := !empty
  io.rd.bits  := rdat
  io.wr.ready := !full
}

class chisel_fifo[T<:Data](gen:T,DP:Int = 0 ) extends fifo_base(gen) {

  io.rd <> Queue(io.wr,DP)

}