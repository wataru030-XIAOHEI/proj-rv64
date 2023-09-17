//================================================================
// file         : core bus
// description  : bus for core 
// author       : Wataru
// version      :
// date         : 2023-08-06
//================================================================
package bus

import chisel3._ 


class core_bus (AW:Int , DW : Int ,PN:String = "location") extends Bundle{
   val rreq = Bool()
   val wreq = Bool()
   val radr = UInt(AW.W)
   val rdat = UInt(DW.W) 
   val wadr = UInt(AW.W)
   val wdat = UInt(DW.W) 
   val rok = Bool()
   val wok = Bool()

   override def toPrintable :Printable = {
        val rv = Mux(rok & rreq,'R'.U,'-'.U)
        val ra = Mux(rok & rreq,radr, 0.U)
        val rd = Mux(rok & rreq,rdat, 0.U)
        val wv = Mux(wok & wreq,'W'.U,'-'.U)
        val wa = Mux(wok & wreq,wadr,0.U)
        val wd = Mux(wok & wreq,wdat,0.U)

        p"$PN.core_bus : \n"+
        p"${Character(rv)} : " +
        p"0x${Hexadecimal(ra)} => 0x${rd} \n"
        p"${Character(wv)} : " +
        p"0x${Hexadecimal(wa)} => 0x${wd} \n"
   }
}

class core_bus_io [T<:Data] (AW:Int = 0 , gen : T,PN :String ="location" ) extends Bundle{
   val rreq = Input(Bool())
   val wreq = Input(Bool())
   val radr = Input(UInt(AW.W))
   val wadr = Input(UInt(AW.W))
   val wdat = Input(gen)
   val wok  = Output(Bool())
   val rdat = Output(gen)
   val rok  = Output(Bool())

   override def toPrintable :Printable = {
        val rv = Mux(rok& rreq,'R'.U,'-'.U)
        val ra = Mux(rok& rreq,radr, 0.U)
        val rd = Mux(rok& rreq,rdat, 0.U)
        val wv = Mux(wok& wreq,'W'.U,'-'.U)
        val wa = Mux(wok& wreq,wadr,0.U)
        val wd = Mux(wok& wreq,wdat,0.U)

        p"$PN.core_bus : \n"+
        p"${Character(rv)} : " +
        p"0x${Hexadecimal(ra)} => 0x${rd} \n"
        p"${Character(wv)} : " +
        p"0x${Hexadecimal(wa)} => 0x${wd} \n"
   }
}
