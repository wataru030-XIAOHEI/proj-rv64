//================================================================
// file         : clk
// description  : clk lib
// author       : Lin Pei Run
// version      :
// date         : 2023-07-17
//================================================================
package libs


import chisel3.util.MuxCase
import chisel3._
class clk extends Module {
  val clko = IO(Output(Clock()))

  val clk_r = RegInit(false.B)
  clk_r := ~clk_r

  clko := clk_r.asClock
}


class clkMux (NR:Int = 0) extends Module {
  val io = IO(new Bundle {
    val change = Input(Bool())
    val clkin = Input(Vec(NR,Bool()))
    val clksel = Input(Input(UInt(NR.W)))
    val clko   = Output(Output(Clock()))
  })
  assert(NR > 0 )

  val sel_r = Reg(UInt(NR.W))

  when(io.change) {sel_r := io.clksel}

  io.clko := MuxCase(false.B,
    for(i <- 0 until NR) yield (sel_r(i) -> io.clkin(i))).asClock
}

//gate clk
class gtclk extends Module {
  val io = IO(new Bundle {
    val ena = Input(Bool())
    val clko = Output(Clock())
  })

  val ena_r = RegInit(false.B)

  ena_r := io.ena

  io.clko := (ena_r & clock.asBool).asClock

}

object gtclk {
  def apply(ena:Bool):Clock = {
    val m = Module(new gtclk)
    m.io.ena := ena
    m.io.clko
  }
}