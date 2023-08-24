//================================================================
// file         : isa_exec_type
// description  : instructions execute type decode
// author       : Lin Pei Run
// version      :
// date         : 2023-08-14
//================================================================
package inst_decode
import chisel3._
object exec_code1{
  val wd :Int = 9
  val NOP : UInt = 0.U(wd.W)
  val NORMAL : UInt = 1.U(wd.W)  //add,sub ,cmp
  val BR  : UInt = 2.U(wd.W)    // branch/jump
  val LOAD: UInt = 4.U(wd.W)    // load
  val STORE:UInt = 8.U(wd.W)    // store
  val SFT : UInt = 16.U(wd.W)   // shift
  val LOGIC:UInt = 32.U(wd.W)   // logic
  val MDR : UInt = 64.U(wd.W)   // mul,div, rem
  val CSR : UInt = 128.U(wd.W)  // csr registers operations
}


object normal_code2{
  private val wd : Int = 9
  val NOP : UInt = 0.U(wd.W)
  val LUI : UInt = "b0 0000 0001".U(wd.W)
  val AUIPC:UInt = "b0 1000 0001".U(wd.W)
  val ADD : UInt = "b0 0000 0010".U(wd.W)
  val ADDI: UInt = "b0 0000 0011".U(wd.W)
  val SUB : UInt = "b0 0100 0000".U(wd.W)
  val SLT : UInt = "b0 0000 0100".U(wd.W)
  val SLTU: UInt = "b1 0000 0100".U(wd.W)
  val SLTI: UInt = "b0 0000 0101".U(wd.W)
  val SLTIU:UInt = "b1 0000 0101".U(wd.W)
  val ADDIW:UInt = "b0 0000 1011".U(wd.W)
  val ADDW :UInt = "b0 0000 1010".U(wd.W)
  val SUBW :UInt = "b0 0100 1000".U(wd.W)
}

object br_code2 {
  private val wd : Int = 9
  val JAL : UInt = "b0 0100 0000".U(wd.W)
  val JALR: UInt = "b0 0100 0001".U(wd.W)
  val BEQ : UInt = "b0 1000 0001".U(wd.W)
  val BNE : UInt = "b0 1000 0010".U(wd.W)
  val BLT : UInt = "b0 1000 0011".U(wd.W)
  val BGE : UInt = "b0 1000 0100".U(wd.W)
  val BLTU: UInt = "b1 1000 0011".U(wd.W)
  val BGEU: UInt = "b1 1000 0100".U(wd.W)
}