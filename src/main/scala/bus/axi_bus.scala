package bus

import chisel3._ 
import chisel3.util._ 
import chisel3.experimental.IO
import isa.isa_I

object axi_chl{
    val id_wd    :Int = 2
    val len_wd   :Int = 4
    val size_wd  :Int = 3 
    val burst_wd :Int = 2
    val cache_wd :Int = 2
    val lock_wd  :Int = 2
    val prot_wd  :Int = 2
}

case class axi_chl_param(
    AW:Int,
    DW:Int,
    WW:Int,
    LENW:Int,
    IDW:Int
){
    require(AW>=16,s"AXI address width must be >= 16 (current aw = ${AW})")
    require(DW%8==0,s"AXI data width must be align with Byte (current dw = ${DW})")
    require(WW*8==DW,s"AXI wstrb width neq DW current ww = ${WW}")
}


class address_chl(p:axi_chl_param) extends Bundle {
    val id = UInt(p.IDW.W)
    val addr = UInt(p.AW.W)
    val size = UInt(if(p.DW==64)3.W else 2.W)
    val len  = UInt(p.LENW.W)
    val burst= UInt(axi_chl.burst_wd.W)
    val lock = UInt(axi_chl.lock_wd.W)
    val cache= UInt(axi_chl.cache_wd.W)
    val prot = UInt(axi_chl.prot_wd.W)
}

object address_chl {
    def apply(p:axi_chl_param)(
    id:UInt,
    adr:UInt,
    size:UInt,
    len:UInt,
    burst:UInt,
    lock:UInt = 0.U,
    cache:UInt= 0.U,
    prot:UInt = 0.U
    ) : address_chl = {
        val ar = Wire(new address_chl(p))
        ar.addr := adr
        ar.id := id 
        ar.size := size
        ar.len := len 
        ar.burst := burst
        ar.lock := lock
        ar.cache := cache 
        ar.prot := prot
        ar
    }
}

class data_channel(p:axi_chl_param) extends Bundle{
    val id   = UInt(p.IDW.W)
    val strb = UInt(p.WW.W)
    val data = UInt(p.DW.W)
    val last = Bool()
    val resp = UInt(2.W)
}

object data_channel{
    def apply(p:axi_chl_param)(
        id:UInt,
        strb:UInt,
        data:UInt,
        last:Bool,
        resp:UInt = 0.U
    ) :data_channel = {
        val d = Wire(new data_channel(p))
        d.data := data
        d.id := id 
        d.strb := strb 
        d.last := last 
        d.resp := resp
        d
    }
}

class b_channel(p:axi_chl_param) extends Bundle{
    val id = UInt(p.IDW.W)
    val resp = UInt(2.W)
}
object b_channel {
    def apply(p:axi_chl_param)(
        id:UInt,
        resp:UInt = 0.U 
    ) : b_channel = {
        val b = Wire(new b_channel(p))
        b.id := id 
        b.resp := resp
        b
    }
}


class axi_channel_io(implicit p : axi_chl_param) extends Bundle {
    val ar = Decoupled(new address_chl(p)) 
    val aw = Decoupled(new address_chl(p))
    val w  = Decoupled(new data_channel(p))
    val r  = Flipped(Decoupled(new data_channel(p)))
    val b  = Flipped(Decoupled(new b_channel(p)))
}


class axi_channle(implicit p : axi_chl_param) extends Bundle {
    val ar = new address_chl(p)
    val aw = new address_chl(p)
    val w  = new data_channel(p)
    val r  = new data_channel(p)
    val b  = new data_channel(p)
}