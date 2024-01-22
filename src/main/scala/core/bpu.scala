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

class bpu extends CModule {
    val io = IO(new Bundle{
        val branch_bus = new branch_bus_io(VAW)
        val npc         = Input(UInt(VAW.W))
    })


    io.branch_bus.branch_bus.adr := 0.U 
    io.branch_bus.branch_bus.vld := false.B 
    
}