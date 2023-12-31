import code_tst.code_bus_prn_tst
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
import libs._
import axi._

//==========================================================
//============ E L A B O R A T E ===========================
//==========================================================
object Elaborate extends App {
  def targetDir : String = "generated"

  def top = {
    new freelist
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