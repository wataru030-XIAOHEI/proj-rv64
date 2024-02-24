package libs

import chisel3._ 
import chisel3.util._ 


object PipelineConnect {
    def apply[T<:Data](enq : DecoupledIO[T],deq : DecoupledIO[T],deq_fire:Bool,Flush:Bool) = {
        val vld = RegInit(false.B)
        when(deq_fire) {vld := false.B}
        when(enq.valid && enq.ready) { vld := false.B}
        when(Flush) { vld := false.B}

        enq.ready := deq.ready
        deq.bits := RegEnable(enq.bits,enq.valid && enq.ready)
        deq.valid := vld
    }
}


class LatencyPipe[T <:Data] (gen:T , latency :Int) extends Module {
    val io = IO(new Bundle {
        val in = Flipped(DecoupledIO(gen))
        val out = DecoupledIO(gen)
    })

    def doN[T](n : Int,func:T=> T ,in: T ):T = 
        (0 to n).foldLeft(in)((last,_) => func(last))


    io.out <> doN(latency,(last:DecoupledIO[T])=>Queue(last,1,pipe=true),io.in)

}

object LatencyPipe {
    def apply[T<:Data](in:DecoupledIO[T],latency:Int):DecoupledIO[T] = {
        val pipe = Module(new LatencyPipe(in.bits.cloneType,latency))
        pipe.io.in <> in 
        pipe.io.out
    }
}
