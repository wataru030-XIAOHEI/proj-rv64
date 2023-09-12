//================================================================
// file         : clk
// description  : clk lib
// author       : Lin Pei Run
// version      :
// date         : 2023-07-17
//================================================================
package libs


import chisel3.util._
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

class clkSwitch2to1 (DLY:Int = 2) extends Module {
  val io = IO(new Bundle {
    val clkin = Input(Vec(2, Clock()))
    val clksel = Input(Input(Bool()))
    val clko = Output(Output(Clock()))
  })

  val sel_clk0 = io.clksel === true.B
  val sel_clk1 = io.clksel === false.B

  val clk_neg = Wire(Vec(2,Bool()))
  val sel_clk0_rd = Wire(UInt(DLY.W))
  val sel_clk0_neg_rd = Wire(UInt(2.W))
  val sel_clk1_rd = Wire(UInt(DLY.W))
  val sel_clk1_neg_rd = Wire(UInt(2.W))

  for(i <- 0 until 2) { clk_neg(i) := ~io.clkin(i).asBool}

  withClockAndReset(io.clkin(0),reset){
    val sel_clk0_r = RegInit(Fill(DLY,"b1".U(1.W)))
    sel_clk0_r :=  Cat(sel_clk0_r(DLY-2,0),(sel_clk0 & !sel_clk1_neg_rd(1)))

    sel_clk0_rd := sel_clk0_r
  }
  withClockAndReset(clk_neg(0).asClock,reset){
    val sel_clk0_neg_r = RegInit("b00".U(2.W))
    sel_clk0_neg_r := Cat(sel_clk0_neg_r(0),sel_clk0_rd(DLY-1))

    sel_clk0_neg_rd := sel_clk0_neg_r
  }

  withClockAndReset(io.clkin(1),reset){
    val sel_clk1_r = RegInit(Fill(DLY,"b0".U(1.W)))
    sel_clk1_r := Cat(sel_clk1_r(DLY-2,0), (sel_clk1 & !sel_clk0_neg_rd(1)))

    sel_clk1_rd := sel_clk1_r 
  }

  withClockAndReset(clk_neg(1).asClock,reset){
    val sel_clk1_neg_r = RegInit("b00".U(2.W))
    sel_clk1_neg_r := Cat(sel_clk1_neg_r(0),sel_clk1_rd(DLY-1))

    sel_clk1_neg_rd := sel_clk1_neg_r 
  }

  val clk_gate = Wire(Vec(2,Bool()))
  clk_gate(0) := io.clkin(0).asBool & sel_clk0_neg_rd(1)
  clk_gate(1) := io.clkin(1).asBool & sel_clk1_neg_rd(1)

  io.clko := clk_gate.asUInt.orR.asClock

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