//================================================================
// file         : isa_I
// description  : RISC-V I Base Integer ISA
// author       : Lin Pei Run
// version      :
// date         : 2023-07-28
//================================================================
package isa
import config._
import chisel3.util.BitPat

object isa_I {
 //I-extends
  def lui  : BitPat = BitPat("b??????? ????? ????? ??? ????? 0110111")
  def auipc: BitPat = BitPat("b??????? ????? ????? ??? ????? 0010111")
  def jal  : BitPat = BitPat("b??????? ????? ????? ??? ????? 1101111")
  def jalr : BitPat = BitPat("b??????? ????? ????? 000 ????? 1100111")
  def beq  : BitPat = BitPat("b??????? ????? ????? 000 ????? 1100011")
  def bne  : BitPat = BitPat("b??????? ????? ????? 001 ????? 1100011")
  def blt  : BitPat = BitPat("b??????? ????? ????? 100 ????? 1100011")
  def bge  : BitPat = BitPat("b??????? ????? ????? 101 ????? 1100011")
  def bltu : BitPat = BitPat("b??????? ????? ????? 110 ????? 1100011")
  def bgeu : BitPat = BitPat("b??????? ????? ????? 111 ????? 1100011")
  def lb   : BitPat = BitPat("b??????? ????? ????? 000 ????? 0000011")
  def lh   : BitPat = BitPat("b??????? ????? ????? 001 ????? 0000011")
  def lw   : BitPat = BitPat("b??????? ????? ????? 010 ????? 0000011")
  def lbu  : BitPat = BitPat("b??????? ????? ????? 100 ????? 0000011")
  def lhu  : BitPat = BitPat("b??????? ????? ????? 101 ????? 0000011")
  def sb   : BitPat = BitPat("b??????? ????? ????? 000 ????? 0100011")
  def sh   : BitPat = BitPat("b??????? ????? ????? 001 ????? 0100011")
  def sw   : BitPat = BitPat("b??????? ????? ????? 010 ????? 0100011")
  def addi : BitPat = BitPat("b??????? ????? ????? 000 ????? 0010011")
  def slti : BitPat = BitPat("b??????? ????? ????? 010 ????? 0010011")
  def sltiu: BitPat = BitPat("b??????? ????? ????? 011 ????? 0010011")
  def xori : BitPat = BitPat("b??????? ????? ????? 100 ????? 0010011")
  def ori  : BitPat = BitPat("b??????? ????? ????? 110 ????? 0010011")
  def andi : BitPat = BitPat("b??????? ????? ????? 111 ????? 0010011")

  if(!Settings.get("RV64")){
  def slli : BitPat = BitPat("b0000000 ????? ????? 001 ????? 0010011")
  def srli : BitPat = BitPat("b0000000 ????? ????? 101 ????? 0010011")
  def srai : BitPat = BitPat("b0100000 ????? ????? 101 ????? 0010011")
  }

  def add  : BitPat = BitPat("b0000000 ????? ????? 000 ????? 0110011")
  def sub  : BitPat = BitPat("b0100000 ????? ????? 000 ????? 0110011")
  def sll  : BitPat = BitPat("b0000000 ????? ????? 001 ????? 0110011")
  def slt  : BitPat = BitPat("b0000000 ????? ????? 010 ????? 0110011")
  def sltu : BitPat = BitPat("b0000000 ????? ????? 011 ????? 0110011")
  def xor  : BitPat = BitPat("b0000000 ????? ????? 100 ????? 0110011")
  def srl  : BitPat = BitPat("b0000000 ????? ????? 101 ????? 0110011")
  def sra  : BitPat = BitPat("b0100000 ????? ????? 101 ????? 0110011")
  def or   : BitPat = BitPat("b0000000 ????? ????? 110 ????? 0110011")
  def and  : BitPat = BitPat("b0000000 ????? ????? 111 ????? 0110011")

//  def UNIMP:BitPat = BitPat("b1100 0000 0000 0000 0001 0000 0111 0011")

  def fence   : BitPat = BitPat("b0000 ???? ???? 00000 000 00000 0001111")
  def fence_i : BitPat = BitPat("b0000 0000 0000 00000 001 00000 0001111")

  // CSR
  def ecall   : BitPat = BitPat("b0000 0000 0000 00000 000 00000 1110011")
  def ebreak  : BitPat = BitPat("b0000 0000 0001 00000 000 00000 1110011")
  def csrrw   : BitPat = BitPat("b???? ???? ???? ????? 001 ????? 1110011")
  def csrrs   : BitPat = BitPat("b???? ???? ???? ????? 010 ????? 1110011")
  def csrrc   : BitPat = BitPat("b???? ???? ???? ????? 011 ????? 1110011")
  def csrrwi  : BitPat = BitPat("b???? ???? ???? ????? 101 ????? 1110011")
  def csrrsi  : BitPat = BitPat("b???? ???? ???? ????? 110 ????? 1110011")
  def csrrci  : BitPat = BitPat("b???? ???? ???? ????? 111 ????? 1110011")

}



object isa_I_rv64 {
  def lwu   : BitPat = BitPat("b??????? ????? ????? 110 ?????? 0000011")
  def ld    : BitPat = BitPat("b??????? ????? ????? 011 ?????? 0000011")
  def sd    : BitPat = BitPat("b??????? ????? ????? 011 ?????? 0100011")
  def slli  : BitPat = BitPat("b000000? ????? ????? 001 ?????? 0010011")
  def srli  : BitPat = BitPat("b000000? ????? ????? 101 ?????? 0010011")
  def srai  : BitPat = BitPat("b010000? ????? ????? 101 ?????? 0010011")
  def addiw : BitPat = BitPat("b??????? ????? ????? 000 ?????? 0011011")
  def slliw : BitPat = BitPat("b0000000 ????? ????? 001 ?????? 0011011")
  def srliw : BitPat = BitPat("b0000000 ????? ????? 101 ?????? 0011011")
  def sraiw : BitPat = BitPat("b0100000 ????? ????? 101 ?????? 0011011")
  def addw  : BitPat = BitPat("b0000000 ????? ????? 000 ?????? 0111011")
  def subw  : BitPat = BitPat("b0100000 ????? ????? 000 ?????? 0111011")
  def sllw  : BitPat = BitPat("b0000000 ????? ????? 001 ?????? 0111011")
  def srlw  : BitPat = BitPat("b0000000 ????? ????? 101 ?????? 0111011")
  def sraw  : BitPat = BitPat("b0100000 ????? ????? 101 ?????? 0111011")
}