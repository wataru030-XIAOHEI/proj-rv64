package config

import chisel3._


trait coreparameter {
  val XLEN = if(Settings.get("RV64")) 64 else 32

  val Mset = Settings.get("ISA-M") // support ISA-M extension
  val Aset = Settings.get("ISA-A") // support ISA-M extension
  val Cset = Settings.get("ISA-C") // support ISA-M extension

  val AW   = 64       //          address width
  val VAW  = 64       // virtual  address width
  val PAW  = 64       // physical address width
  val AB   = AW / 8   //          address bytes
  val WD   = XLEN     //          data    width

  val VMEM_EN = if(Settings.get("hasDTLB")&&Settings.get("hasITLB")) true else false


}

trait coreConst extends coreparameter {
}

trait HasCoreLog{ this: RawModule =>
  implicit val moduleName : String = this.name
}

// core module class
abstract class CModule extends Module with coreparameter with coreConst with HasCoreLog
// core bundle class
abstract class CBundle extends Bundle with coreparameter with coreConst



