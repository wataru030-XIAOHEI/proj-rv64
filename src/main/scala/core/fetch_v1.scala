//================================================================
// file         : fetch bus
// description  : bus for fetch data
// author       : Wataru
// version      :
// date         : 2023-10-06
//================================================================
package core

import config.coreparameter
import bus.core_bus_io
import chisel3.Bundle
import bus.core_bus_param
import chisel3._
import chisel3.util._
import config.CBundle
import config.CModule
import config.Settings
import bus._
import firrtl.options.DoNotTerminateOnExit




// to cache , and bpu 
class fetch_bus_l0(AW:Int) extends CBundle { 
    val req  = Output(Bool())
    val adr  = Output(UInt(AW.W)) // current adr , to cache 
    val nadr = Output(UInt(AW.W)) // next adr , to bpu , offset : fetch group,TODO
    val ack  = Input(Bool())
}

class fetch_io_l0 extends CBundle {
    val restart_bus = Flipped(new branch_bus_io(VAW))
    val fe_br_bus   = Flipped(new branch_bus_io(VAW))
    val be_br_bus   = Flipped(new branch_bus_io(VAW))
    val fetch_bus   = new fetch_bus_l0(VAW) 

    val deq         = Decoupled(UInt(VAW.W))
}

class fetch_l0 extends CModule {
    val io = IO(new fetch_io_l0)


    val pc = RegInit(Settings.getLong("rstVec").U(VAW.W))

    val npc = Wire(UInt(pc.getWidth.W))

    npc := MuxCase(pc,Seq(
        io.restart_bus.branch_bus.vld -> io.restart_bus.branch_bus.adr,
        io.be_br_bus.branch_bus.vld -> io.be_br_bus.branch_bus.adr,
        io.fe_br_bus.branch_bus.vld -> io.fe_br_bus.branch_bus.adr,
        io.fetch_bus.ack            -> (pc + (1 << IF_OFFSET).U)
    ))

    pc := npc


    
    io.fetch_bus.req  := io.deq.ready & true.B  
    io.fetch_bus.adr  := pc 
    io.fetch_bus.nadr := npc
    
    io.deq.valid := io.fetch_bus.ack
    io.deq.bits  := pc 

}

class fetch_io_l1 extends CBundle {
    val bpu_bus = new fetch_bus_l0(VAW)
    val enq = Flipped(Decoupled(UInt(VAW.W)))
    val deq = Decoupled(UInt(VAW.W))
}

class fetch_l1 extends CModule {
    val io = IO(new fetch_io_l1)

 
    io.deq <> ppline(io.enq,reset)

    io.bpu_bus.req  := io.deq.valid
    io.bpu_bus.adr  := io.deq.bits
    io.bpu_bus.nadr := 0.U
}


class fetch_2stages extends CModule {
    val io = IO(new Bundle {
        val l0 = new Bundle {
            val restart_bus = Flipped(new branch_bus_io(VAW))
            val fe_br_bus   = Flipped(new branch_bus_io(VAW))
            val be_br_bus   = Flipped(new branch_bus_io(VAW))
            val fetch_bus   = new fetch_bus_l0(VAW) 
        }
        val l1 = new Bundle {
            val bpu_bus = new fetch_bus_l0(VAW)
        }
        val deq = Decoupled(UInt(VAW.W))
    })

    val l0 = Module(new fetch_l0)
    val l1 = Module(new fetch_l1)

    l0.io.be_br_bus     <> io.l0.be_br_bus
    l0.io.fe_br_bus     <> io.l0.fe_br_bus
    l0.io.restart_bus   <> io.l0.restart_bus
    l0.io.fetch_bus     <> io.l0.fetch_bus 
    l1.io.bpu_bus       <> io.l1.bpu_bus


    l1.io.enq <> l0.io.deq
    io.deq <> l1.io.deq

    util.experimental.forceName(io.deq.bits,"out_pc")
    util.experimental.forceName(io.deq.valid,"out_"+io.deq.valid.name)
    util.experimental.forceName(io.deq.ready,"out_"+io.deq.ready.name)

}