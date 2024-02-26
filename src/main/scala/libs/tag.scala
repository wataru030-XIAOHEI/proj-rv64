//================================================================
// file         : tagram 
// description  : 
// author       : Master
// version      : v0.0.0
// date         : 2023-12-9
//================================================================

package  libs
import chisel3._

class tagramIO extends Bundle{
    val w_addr = Input(UInt(8.W))
    val w_data = Input(UInt(22.W))
    val w_en   = Input(Bool())
    val r_addr = Input(UInt(8.W))

    val r_data = Output(UInt(22.W))

}

class TAGRAM extends Module{
    val io = IO(new tagramIO)
    val ram = RegInit(VecInit(Seq.fill(64*4)(0.U(22.W))))
    val w_data_r = RegInit(0.U(22.W))
    w_data_r := io.w_data
    val q = WireInit(0.U(22.W))
    
    when (io.w_en){
        ram(io.w_addr) := w_data_r
    }

    when (true.B){
        q := ram(io.r_addr)
    }

    io.r_data := q
    
}