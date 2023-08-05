//================================================================
// file         : axi_gen_test
// description  : axi interface generated test
// author       : Wataru
// version      :
// date         : 2023-08-06
//================================================================
package libs

import bus._
import chisel3._


class axi_gen_test[T<:Data](gen:T) extends Module {
  // axi_io class usage
  val axi_mst = IO(Flipped(new axi_io(gen)))
  val axi_slv = IO(new axi_io(gen))

  // axi_bundle class usage
  val temp_axi_bundle = WireInit(0.U.asTypeOf(new axi_bundle(gen)))


  dontTouch(temp_axi_bundle)

  dontTouch(axi_mst)
  dontTouch(axi_slv)


  axi_slv <> axi_mst
}

