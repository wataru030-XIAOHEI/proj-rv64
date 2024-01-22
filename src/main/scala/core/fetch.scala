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



// class fetch_io extends CBundle{
//     val restart_bus = Flipped(new branch_bus_io(VAW))
//     val branch_bus = Flipped(new branch_bus_io(VAW))
//     val fetch_bus = new fetch_inst_bus(VAW,XLEN,IF_NR)

//     val fetch_inst = Output(Vec(IF_NR,UInt(XLEN.W)))
//     val npc        = Output(UInt(VAW.W))
// }

// class fetch_l0_base extends CModule { //fetch level 0 
//     val io = IO(new fetch_io)
// }

// class fetch_l1_base extends CModule { //fetch level 1
//     val io = IO(new fetch_io)
// }

// class fetch_l0 extends fetch_l0_base {
//     val pc = RegInit(Settings.getLong("rstVec").U(VAW.W))
//     val pc_in = Wire(UInt(pc.getWidth.W))

//     val pc_plus = Wire(UInt(pc.getWidth.W))

//     if(IF_NR == 1 ) { pc_plus := 4.U} 
//     else {
//         val vld_cnt = PopCount(VecInit(for(i <- io.fetch_bus.rvld) yield i ))
//         pc_plus := vld_cnt << 2 
//     }

//     //TODO cut pc , pc <= { pc[x:y], {y{1'b0}} }
//     pc_in := MuxCase(pc,Array(
//         io.restart_bus.branch_bus.vld     -> io.restart_bus.branch_bus.adr,
//         io.branch_bus.branch_bus.vld      -> io.branch_bus.branch_bus.adr, 
//         io.fetch_bus.rvld.reduceTree(_|_) -> (pc + pc_plus)
//     ))

//     pc := pc_in 
//     io.fetch_inst := io.fetch_bus.rdat

//     io.fetch_bus.radr := pc 
//     io.fetch_bus.rreq := true.B //TODO
    
//     io.npc := pc_in 

// }

// /**
//   * 
//   *  fetch_l0 , Bpu , pipeline
//   *
//   */
// class fetch_l1 extends  fetch_l1_base {

//     val bpu_br_bus = Wire(new branch_bus(VAW))

//     val fetch_l0_br_bus = Wire(new branch_bus(VAW))

//     fetch_l0_br_bus.vld := io.branch_bus.branch_bus.vld | bpu_br_bus.vld 
//     fetch_l0_br_bus.adr := Mux(io.branch_bus.branch_bus.vld , io.branch_bus.branch_bus.adr,
//                             Mux(bpu_br_bus.vld,bpu_br_bus.adr, 0.U ))

//     val fetch_l0 = Module(new fetch_l0)


//     fetch_l0.io.fetch_bus <> io.fetch_bus
//     fetch_l0.io.restart_bus <> io.restart_bus

//     fetch_l0.io.branch_bus.branch_bus.adr := bpu_br_bus.adr 
//     fetch_l0.io.branch_bus.branch_bus.vld := bpu_br_bus.vld

//     //TODO
//     io.npc := 0.U //unused 

//     // BPU 
//     val bpu = Module(new bpu)

 

//     bpu_br_bus.adr := bpu.io.branch_bus.branch_bus.adr
//     bpu_br_bus.vld := bpu.io.branch_bus.branch_bus.vld
//     bpu.io.npc := fetch_l0.io.npc

//     // TODO , need pipe line ?
//     fetch_l0.io.fetch_inst <> io.fetch_inst

//     // DONT TOUCH 
//    dontTouch(bpu.io)
// }