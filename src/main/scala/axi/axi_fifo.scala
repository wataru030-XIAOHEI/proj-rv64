//================================================================
// file         : fifo
// description  : fifo for axi
// author       : Wataru
// version      :
// date         : 2023-08-06
//================================================================
package axi
import libs.fifo_base
import chisel3._
import chisel3.util.Queue


class axi_fifo[T<:Data](gen:T,DP:Int = 0 ) extends fifo_base(gen) {
  io.rd <> Queue(io.wr,DP)
}
