//================================================================
// file         : elaborate
// description  : elaborate scala file to verilog file
// author       : Lin Pei Run
// version      :
// date         : 2022-11-25
//================================================================


import chisel3.stage.ChiselStage
import circt.stage._
import chisel3._
import chisel3.util._
import libs.{axi_gen_test, fifo, gtclk}

//==========================================================
//============ E L A B O R A T E ===========================
//==========================================================
object Elaborate extends App {
  def targetDir : String = "generated"

  def top = {
    new axi_gen_test(UInt(32.W))
  } // change the top module class
  /**@note you can modify this defination to change the generation tool .*/
  def useCIRCT = true

  def gen_top: Seq[chisel3.stage.ChiselGeneratorAnnotation] = Seq(chisel3.stage.ChiselGeneratorAnnotation(() => top))

  if(useCIRCT){
    (new ChiselStage).execute(Array("--target-dir", targetDir), gen_top :+ CIRCTTargetAnnotation(CIRCTTarget.Verilog))
  } else{
    (new ChiselStage).execute(Array("--target-dir", targetDir), gen_top )
  }

  println(
    s"""
       |[INFO]: Elaborated Successful !
       |[INFO]: firrtl tool is ${if(useCIRCT){"CIRCT-firrtl"}else{"sbt-firrtl"}}
       |[INFO]: generate the module .
       |[INFO]: please checkout the target-dir=> [${targetDir}]
       |""".stripMargin)
}


class tempMux (NR:Int = 0 ,WD:Int = 0)extends RawModule {
  val in  = IO(Input(Vec(NR,UInt(WD.W))))
  val sel = IO(Input(UInt(NR.W)))
  val out = IO(Output(UInt(WD.W)))

  assert(NR>=1)
  assert(WD> 0)
  out := MuxCase(0.U(1.W),for(i <- 0 until NR) yield (sel(i) -> in(i) ))

}