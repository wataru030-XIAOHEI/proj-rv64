//================================================================
// file         : core bus
// description  : bus for core 
// author       : Wataru
// version      :
// date         : 2023-08-06
//================================================================
package bus

import chisel3._ 
import chisel3.util._

case class core_bus_param (
   AW:Int ,
   DW:Int ,
   WW:Int )
{
   require(AW>0,s"address width must be >= 0 (current AW = ${AW})")
   require((DW%8)==0,s"data width must be Byte align (current DW = ${DW})")
   require(WW*8==DW,s"strb width must is data byte num (current WW = ${WW})")
}

class core_adr(p:core_bus_param) extends Bundle{
   val address = UInt(p.AW.W)
}

class core_dat(p:core_bus_param) extends Bundle{
   val data = UInt(p.DW.W)
   val strb = UInt(p.WW.W)

}


object core_adr{
   def apply(p:core_bus_param)(adr:UInt) : core_adr = {
      val adr = Wire(new core_adr(p))
      adr.address := adr 
      adr
   }
}

object core_dat{
   def apply(p:core_bus_param)(dat:UInt,strb:UInt) : core_dat = {
      val dat = Wire(new core_dat(p))
      dat.data := dat 
      dat.strb := strb
      dat
   }
}


class core_bus_io(p:core_bus_param) extends Bundle{
   val ra = Flipped(Valid(new core_adr(p)))
   val wa = Flipped(Valid(new core_adr(p)))
   val rd = Valid(new core_dat(p))
   val wd = Flipped(Valid(new core_dat(p)))

   override def toPrintable : Printable = {
      val rav = Mux(ra.valid,'*'.U,'-'.U)
      val wav = Mux(wa.valid,'*'.U,'-'.U)
      val rdv = Mux(rd.valid,'*'.U,'-'.U)
      val wdv = Mux(wd.valid,'*'.U,'-'.U)
   
      p"===============================================\n" +
      p"radr  ===> ${Character(rav)} : 0x${Hexadecimal(ra.bits.address)}\n" + 
      p"rdat  ===> ${Character(rdv)} : 0x${Hexadecimal(rd.bits.data)}\n" +
      p"wadr  ===> ${Character(wav)} : 0x${Hexadecimal(wa.bits.address)}\n" + 
      p"wdat  ===> ${Character(wdv)} : 0x${Hexadecimal(wd.bits.data)}\n" +
      p"wstrb ===> ${Character(wdv)} : 0x${Binary(wd.bits.strb)}\n" +
      p"===============================================\n" 
   }
}
