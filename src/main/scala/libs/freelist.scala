//================================================================
// file         : sram model
// description  : sram model
// author       : Wataru
// version      :
// date         : 2023-09-18
//================================================================
package libs

import chisel3._ 
import chisel3.util._ 
import config._ 
import chisel3.util.experimental.loadMemoryFromFile

trait freelist_param {
    val DP : Int = Settings.getInt("PRFNR")
    val NR = Settings.getInt("ISSUEWD")
    val PREG_WD = log2Ceil(Settings.getInt("PRFNR"))
}


class freelist_io extends CBundle with freelist_param{
    val req = Input(Vec(NR,Bool()))
    val pidx = Output(Vec(NR,UInt(PREG_WD.W)))
    val pvld = Output(Vec(NR,Bool()))
    val busy = Output(Bool())

    val rls  = Input(Vec(NR,Bool()))
    val rls_pidx = Input(Vec(NR,UInt(PREG_WD.W)))

}

abstract class freelist_base extends CModule with freelist_param{
    val io = IO(new freelist_io)
}


class freelist extends freelist_base {
    val idx_r = Mem(DP,UInt(PREG_WD.W))
    loadMemoryFromFile(idx_r,"../data/freelist.mem")
    val idx_rptr = RegInit(0.U((PREG_WD+1).W))
    val idx_wptr = RegInit(DP.U((PREG_WD+1).W))

    val empty = Wire(Bool())
    val full  = Wire(Bool())
    
    val re = io.req.reduceTree(_|_) & !empty 
    val we = io.rls.reduceTree(_|_) & !full
    
    val r_pidx_sum = Wire(UInt(log2Ceil(NR).W))
    val w_pidx_sum = Wire(UInt(log2Ceil(NR).W))
    r_pidx_sum := (for(i <- io.req) yield i.asUInt).reduce(_+&_)
    w_pidx_sum := (for(i <- io.rls) yield i.asUInt).reduce(_+&_)
    

    val r_onehot = Wire(UInt(NR.W))
    val w_onehot = Wire(UInt(NR.W))
    r_onehot := Cat((for(i <- 0 until NR) yield (r_pidx_sum > i.U)).reverse)
    w_onehot := Cat((for(i <- 0 until NR) yield (w_pidx_sum > i.U)).reverse)

    val wr_pidx = Wire(Vec(NR,UInt(PREG_WD.W)))

    for(i <- 0 until NR){
        wr_pidx(i) := MuxCase(0.U(PREG_WD.W),
        for(n <- i until NR) yield ( io.rls(n) -> io.rls_pidx(n)))
    }
    

    val rd_pidx = Wire(Vec(NR,UInt(PREG_WD.W)))
    val rd_pvld = Wire(Vec(NR,Bool()))

    when(re){ idx_rptr := idx_rptr + r_pidx_sum }
    when(we){ idx_wptr := idx_wptr + w_pidx_sum }

    for(i <- 0 until NR){
        when(w_onehot(i) & we){ idx_r(idx_wptr+i.U) := wr_pidx(i) }
        when(r_onehot(i) & re){ 
            rd_pidx(i) := idx_r(idx_rptr+i.U)
            rd_pvld(i) := true.B 
        }.otherwise{
            rd_pidx(i) := 0.U 
            rd_pvld(i) := false.B
        }
    }

    //realign the read pidx to fix order
    for(i <- 0 until NR){
        when(io.req(i)){
            if(i == 0){
                val sum = io.req(0).asUInt.suggestName("is1_sum")
                io.pidx(i) := MuxCase(0.U,
                        for(n <- i until NR ) yield (r_onehot(n) -> rd_pidx(n)))
                io.pvld(i) := MuxCase(false.B,
                        for(n <- i until NR ) yield (r_onehot(n) -> true.B))
            }else{
                val sum = (for(x <- 0 until i ) yield (io.req(x).asUInt)).reduce(_+&_).suggestName("else1_sum")
                io.pidx(i) := MuxCase(0.U,
                        for(n <- 0 until NR ) yield ((r_onehot(n) & (n.U >= sum)) -> rd_pidx(n)))
                io.pvld(i) := MuxCase(0.U,
                        for(n <- 0 until NR ) yield ((r_onehot(n) & (n.U >= sum)) -> rd_pvld(n)))
            }
        }.otherwise{
            io.pidx(i) := 0.U 
            io.pvld(i) := false.B
        }
    }    

    val tail_bit = log2Ceil(NR)
    empty := idx_wptr(PREG_WD,tail_bit) === idx_rptr(PREG_WD,tail_bit)
    full  := (idx_wptr.head(1) =/= idx_rptr.head(1)) && 
              idx_wptr(PREG_WD-1,tail_bit) === idx_rptr(PREG_WD-1,tail_bit)
    io.busy := empty
}