//================================================================
// file         : sram model
// description  : sram model
// author       : Wataru
// version      :
// date         : 2023-09-18
//================================================================
package libs

import chisel3._ 
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile

object sram_type {
    type SRAM_TY = String
    val SYNC :SRAM_TY = "sync"
    val ASYNC:SRAM_TY = "async"
}

class  sram_model_io(AW:Int=0) extends Bundle{
    val adr   = Input(UInt(AW.W)) //Note : 4Byte align !!!
    val cen   = Input(Bool())     //low active
    val wen   = Input(Bool())     //low active ,0:write , 1:read
    val wstrb = Input(UInt(4.W))  //byte write enable 1:enable,0:disable
    val d     = Input(UInt(32.W))
    val q     = Output(UInt(32.W))
}


class asnyc_sram_model(
    DP:Int,  
    LOAD:Boolean =false, 
    MEMF:String="",
    DEBUG:Boolean = false
) extends Module {
    assert(DP>0,s"this ${this.getClass().getName()}.DP is 0 !!! please fix this problem !")
    val size = DP * 32
    val AW = log2Ceil(DP)
    val io = IO(new sram_model_io(AW))


    val mem = Mem(DP,UInt(32.W))
    if(LOAD) {
        assert(MEMF != "","Memory file should not be none !!")
        loadMemoryFromFile(mem,MEMF)
    }
    val re  = !io.cen &  io.wen 
    val we  = !io.cen & !io.wen

    io.q := Mux(re,mem.read(io.adr),0.U(32.W))

    val wr_rd_pre = mem.read(io.adr)
    val wr_pre = Wire(UInt(32.W))

    wr_pre := Cat((for(i <- 0 until 4) yield 
                    (Mux(we & io.wstrb(i),io.d((i+1)*8-1,i*8),wr_rd_pre((i+1)*8-1,i*8)))
                ).reverse)
    when(we){ mem.write(io.adr,wr_pre) }


    if(DEBUG){
        val rv = Wire(Bool())
        val wv = Wire(Bool())
        rv := re 
        wv := we
        when(rv){
            printf(p"rd mem[0x${Hexadecimal(io.adr)}] => 0x${Hexadecimal(io.q)}")
        }
        when(wv){
            printf(p"wr mem[0x${Hexadecimal(io.adr)}] := 0x${Hexadecimal(io.d)}")
            printf(p"  wstrb : 0x${Hexadecimal(io.wstrb)}")
        }
    }
}



class snyc_sram_model(
    DP:Int,  
    LOAD:Boolean =false, 
    MEMF:String="",
    DEBUG:Boolean = false
) extends Module {
    assert(DP>0,s"this ${this.getClass().getName()}.DP is 0 !!! please fix this problem !")
    val size = DP * 32
    val AW = log2Ceil(DP)
    val io = IO(new sram_model_io(AW))


    val mem = Mem(DP,UInt(32.W))
    if(LOAD) {
        assert(MEMF != "","Memory file should not be none !!")
        loadMemoryFromFile(mem,MEMF)
    }
    val re  = !io.cen &  io.wen 
    val we  = !io.cen & !io.wen


    val rdat_dly = RegInit(0.U(32.W))
    when(re)  { rdat_dly := mem.read(io.adr) }
    .otherwise{ rdat_dly := 0.U(32.W) }

    io.q := rdat_dly

    val wr_rd_pre = mem.read(io.adr)
    val wr_pre = Wire(UInt(32.W))

    wr_pre := Cat((for(i <- 0 until 4) yield 
                    (Mux(we & io.wstrb(i),io.d((i+1)*8-1,i*8),wr_rd_pre((i+1)*8-1,i*8)))
                ).reverse)


    when(we){ mem.write(io.adr,wr_pre) }


    if(DEBUG){
        val rv = Wire(Bool())
        val wv = Wire(Bool())
        rv := re 
        wv := we
        when(rv){
            printf(p"rd mem[0x${Hexadecimal(io.adr)}] => 0x${Hexadecimal(io.q)}\n")
        }
        when(wv){
            printf(p"wr mem[0x${Hexadecimal(io.adr)}] := 0x${Hexadecimal(io.d)}")
            printf(p"  wstrb : 0x${Hexadecimal(io.wstrb)}\n")
        }
    }
}



class sram_model(
    DP   :Int,  
    TY   :sram_type.SRAM_TY = sram_type.SYNC,
    LOC  :String = "location",
    DEBUG:Boolean = false,
    LOAD :Boolean =false, 
    MEMF :String=""
) extends Module {
    assert(DP>0,s"this ${this.getClass().getName()}.DP is 0 !!! please fix this problem !")
    val size = DP * 32
    val AW = log2Ceil(DP)
    val io = IO(new sram_model_io(AW))


    if(TY==sram_type.SYNC){
        println(s"gen the sync_${LOC}.sram")
        val mem = Module(new snyc_sram_model(DP,LOAD,MEMF,DEBUG))
        mem.io <> io
    }else{
        println(s"gen the sync_${LOC}.sram")
        val mem = Module(new asnyc_sram_model(DP,LOAD,MEMF,DEBUG))
        mem.io <> io
    }
}