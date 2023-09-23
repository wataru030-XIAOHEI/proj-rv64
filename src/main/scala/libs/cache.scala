//================================================================
// file         : cache 
// description  : CACHE
// author       : Lin Pei Run
// version      : v0.0.0
// date         : 2023-09-15
//================================================================
package libs

import bus._
import chisel3._ 
import chisel3.util._ 

case class cache_param(
    AW:Int,
    DW:Int,
    LINE_BYTE_NUM:Int,
    DP:Int ,
    WAYS:Int
){
    val OFFSET :Int = log2Ceil(LINE_BYTE_NUM)
    val INDEX  :Int = log2Ceil(DP)

    def get_adr_offset(adr:UInt) :UInt = adr(OFFSET-1,0)
    def get_adr_index(adr:UInt) :UInt = adr(INDEX-1,OFFSET)
    def get_adr_tag(adr:UInt) :UInt = adr(AW-1,INDEX)

}


class cache_io(implicit p : cache_param ) extends Bundle {
    val core_bus = new core_bus_io(core_bus_param(p.AW,p.DW,(p.DW/8)))
    val axi_mst  = new axi_channel_io()(axi_chl_param(
        p.AW,
        p.DW,
        (p.DW/8),
        axi_chl.len_wd,
        axi_chl.id_wd
    ))
}

class cache_base(implicit p : cache_param) extends Module {
    val io = IO(new cache_io()(p))

    val ra_tag = p.get_adr_tag(io.core_bus.ra.bits.address)
    val wa_tag = p.get_adr_tag(io.core_bus.wa.bits.address)
}