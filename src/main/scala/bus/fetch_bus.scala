//================================================================
// file         : fetch bus
// description  : bus for fetch data
// author       : Wataru
// version      :
// date         : 2023-10-06
//================================================================
package bus


import chisel3._ 
import chisel3.util._

class fetch_inst_bus(AW:Int,DW:Int,NR:Int) extends Bundle {
    val rreq = Output(Bool())
    val radr = Output(UInt(AW.W))
    val rdat = Input(Vec(NR,UInt(DW.W)))
    val rvld = Input(Vec(NR,Bool()))
}


class branch_bus(AW:Int) extends Bundle {
    val vld = Bool()
    val adr = UInt(AW.W)
}


class branch_bus_io(AW:Int) extends Bundle {
    val branch_bus = Output(new branch_bus(AW))
}