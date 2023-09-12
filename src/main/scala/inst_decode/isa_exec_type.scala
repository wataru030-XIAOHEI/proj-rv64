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

object load_code2{
  private val wd : Int = 9 
  val LB  : UInt = "b0 0000 0001".U(wd.W)
  val LBU : UInt = "b1 0000 0001".U(wd.W)
  val LH  : UInt = "b0 0000 0010".U(wd.W)
  val LHU : UInt = "b1 0000 0010".U(wd.W)
  val LW  : UInt = "b0 0000 0100".U(wd.W)
  val LWU : UInt = "b1 0000 0100".U(wd.W)
  val LD  : UInt = "b0 0000 1000".U(wd.W)
}

object store_code2{
  private val wd :Int = 9 
  val SB  : UInt = "b0 0000 0001".U(wd.W)
  val SH  : UInt = "b0 0000 0010".U(wd.W)
  val SW  : UInt = "b0 0000 0100".U(wd.W)
  val SD  : UInt = "b0 0000 1000".U(wd.W)
}

object shift_code2{
  private val wd : Int = 9
  val SLL		: UInt = "b000000010".U
  val SRL		: UInt = "b000000100".U
  val SRA		: UInt = "b000001100".U
  val SLLI	: UInt = "b000000011".U
  val SRLI	: UInt = "b000000101".U
  val SRAI	: UInt = "b000001101".U
  val SLLW	: UInt = "b000010010".U
  val SRLW	: UInt = "b000010100".U
  val SRAW	: UInt = "b000011100".U
  val SLLIW : UInt = "b000010011".U
  val SRLIW : UInt = "b000010101".U
  val SRAIW : UInt = "b000011101".U
}


object logic_code2{
  private val wd : Int = 9
  val XOR : UInt = "b0 0000 0010".U
  val OR  : UInt = "b0 0000 0100".U
  val AND : UInt = "b0 0000 0110".U
  val XORI: UInt = "b0 0000 0011".U
  val ORI : UInt = "b0 0000 0101".U
  val ANDI: UInt = "b0 0000 0111".U
}

// mult div rem 
object mdr_code2{
  private val wd : Int = 9 
  val MUL : UInt = "b0 0000 0001".U
}