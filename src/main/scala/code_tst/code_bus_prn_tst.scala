package code_tst

import bus._
import chisel3._ 
import chisel3.util._ 

class code_bus_prn_tst extends Module {
    val io = IO(new core_bus_io(4,UInt(32.W ),"cb_prn_tst"))

    val con_reg = RegInit(VecInit.fill(16)(0.U(32.W)))
    val con_re  = Wire(Vec(16,Bool()))
    val con_we  = Wire(Vec(16,Bool()))



    io.rdat := MuxCase(0.U(32.W),
                        for(i <- 0 until con_re.length)
                        yield{con_re(i) -> con_reg(i)})


    io.rok := con_re.reduceTree(_|_)
    io.wok := con_we.reduceTree(_|_)

    for(i <- 0 until 16){
        con_re(i) := (io.radr === i.U) && io.rreq
        con_we(i) := (io.wadr === i.U) && io.wreq

        when(con_we(i)) {con_reg(i) := io.wdat}
    }
    //debug
    printf(p"$io")
    
}