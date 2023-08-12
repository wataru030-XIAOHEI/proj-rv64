//================================================================
// file         : axi_bus
// description  : axi interface
// author       : Wataru
// version      :
// date         : 2023-08-05
//================================================================
package bus
import chisel3._
import chisel3.util._


class axi_ar(
               AW:Int  = 32 ,
               LW:Int  = 4  ,
               IDW:Int = 4
            ) extends Bundle {
  val arid    = UInt(IDW.W)
  val araddr  = UInt(AW.W)
  val arsize  = UInt(3.W)
  val arlen   = UInt(LW.W)
  val arbusrt = UInt(2.W)
  val arlock  = UInt(2.W)
  val arcache = UInt(2.W)
  val arprot  = UInt(2.W)

}

class axi_r[T<:Data](
                    gen : T ,
                    IDW:Int = 4
                    ) extends Bundle {
  val rid    = UInt(IDW.W)
  val rdata  = gen
  val rresp  = UInt(2.W)
  val rlast  = Bool()

}


class axi_aw(
              AW:Int  = 32 ,
              LW:Int  = 4  ,
              IDW:Int = 4
            ) extends Bundle {
  val awid    = UInt(IDW.W)
  val awaddr  = UInt(AW.W)
  val awsize  = UInt(3.W)
  val awlen   = UInt(LW.W)
  val awbusrt = UInt(2.W)
  val awlock  = UInt(2.W)
  val awcache = UInt(2.W)
  val awprot  = UInt(2.W)
}

class axi_w[T<:Data](
                      gen : T ,
                      IDW:Int = 4
                    ) extends Bundle {
  val wid    = UInt(IDW.W)
  val wstrb  = UInt(4.W)
  val wdata  = gen
  val wlast  = Bool()

}

class axi_b (
            IDW: Int = 4
            ) extends Bundle {
  val bid   = UInt(IDW.W)
  val bresp = UInt(2.W)
}


class axi_bundle[T<:Data](
                      gen : T ,
                      AW:Int = 32 ,
                      LW:Int = 4  ,
                      IDW:Int= 4
                      )extends Bundle{
  val ar_chl = DecoupledIO(new axi_ar(AW,LW,IDW))
  val r_chl  = DecoupledIO(new axi_r(gen,IDW))
  val aw_chl = DecoupledIO(new axi_aw(AW,LW,IDW))
  val w_chl  = DecoupledIO(new axi_w(gen,IDW))
  val b_chl  = DecoupledIO(new axi_b(IDW))

}

class axi_io[T<:Data](
                     gen : T ,
                     AW  : Int = 32 ,
                     LW  : Int = 4  ,
                     IDW : Int = 4  ,
                     ) extends Bundle {
  val ar_chl  = Decoupled(Output(new axi_ar(AW,LW,IDW)))
  val r_chl   = Flipped(Decoupled(Output(new axi_r(gen,IDW))))
  val aw_chl  = Decoupled(Output(new axi_aw(AW,LW,IDW)))
  val w_chl   = Decoupled(Output(new axi_w(gen,IDW)))
  val b_chl   = Flipped(Decoupled(Output(new axi_b(IDW))))
}

