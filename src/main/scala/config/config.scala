package config

import chisel3._

object defaultSettings {
  def apply() = Map(
    "rstVec"      -> 0x0000000080000000L ,
    "memBase"     -> 0x0000000000000000L ,
    "mmioBase"    -> 0x0000000000000000L ,
    "mmioSize"    -> 0x30000,

    "hasIcache"   -> false ,
    "hasDcache"   -> false ,
    "hasDTLB"     -> false ,
    "hasITLB"     -> false ,

    "MmodeOnly"   -> true  ,

    "RV64"        -> true  ,

    "ISA-M"       -> false  ,
    "ISA-A"       -> false  ,
    "ISA-C"       -> false  ,


    //core's config
    "IFWD"        -> 1      , //fetch width
    "ISSUEWD"     -> 1      , //issue width
    "HasFPU"      -> false  ,

    "IQDP"        -> 1      , //instructions queue depth
    "ISSUEDP"     -> 1      , //issue queue depth
    "ROBDP"       -> 1      , //re-order buffer depth
    "SBDP"        -> 1      , //store buffer depth

    "ROLLBACK"    -> false  ,

    "PRFNR"       -> 64     ,

    //simulation supprot
    "fpgaSupport" -> false
  )
}


object Settings {
  var settings : Map[String,AnyVal] = defaultSettings()
  def get(field : String)     =   settings(field).asInstanceOf[Boolean]
  def getLong(field : String) =   settings(field).asInstanceOf[Long]
  def getInt (field : String) =   settings(field).asInstanceOf[Int]
}