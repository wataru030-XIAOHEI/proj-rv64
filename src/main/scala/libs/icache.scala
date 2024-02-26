//================================================================
// file         : icache 
// description  : 16KB , 4way , LRU
// author       : Master
// version      : v0.0.0
// date         : 2023-12-11
//================================================================

package libs

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

object CacheStates extends ChiselEnum {
  val IDLE  = Value(0.U)    
  val COMP  = Value(1.U)    
  val HIT   = Value(2.U)    
  val FETCH = Value(3.U)  
  val WAIT  = Value(4.U)  

}

class IcacheIO extends Bundle {  
  val icache_miss       = Output(UInt(64.W))
  val cache_hit         = Output(UInt(64.W))

  val clear         = Input(Bool())

  val cpu_r_addr    = Input(UInt(32.W))
  val cpu_r_valid   = Input(Bool())
  val o_cpu_rdata   = Output(UInt(32.W)) 

  val ifu_ready     = Input(Bool())
  val cache_valid   = Output(Bool())

  val axi_r_ready = Input(Bool())     
  val axi_r_data  = Input(UInt(32.W))
  val axi_r_last  = Input(Bool())

  val axi_ar_valid = Output(Bool())        
  val axi_ar_addr  = Output(UInt(32.W))
  val axi_ar_len   = Output(UInt(8.W))
}
class ICACHE extends Module{
  val io = IO(new IcacheIO)

  val cache_hit   = RegInit(0.U)
  val icache_miss = RegInit(0.U)

  val cache_clear = io.clear

  val axi_r_ready = io.axi_r_ready
  val axi_r_last  = io.axi_r_last
  val axi_r_data  = io.axi_r_data

  val axi_ar_valid = WireInit(false.B)
  val axi_ar_addr  = WireInit(0.U(32.W))
  val axi_ar_len   = WireInit(0.U(8.W))

  val cpu_r_valid = io.cpu_r_valid
  val ifu_ready   = io.ifu_ready

  val cpu_r_addr   = io.cpu_r_addr

  val icache_tag   = cpu_r_addr(31,12)
  val icache_index = cpu_r_addr(11,4)
  // val icache_offset  = cpu_r_addr(3,0)

  // val numSets = 4 
  // val sets = Seq.fill(numSets)(Module(new SET))

  val set0 = Module(new SET)
  val set1 = Module(new SET)
  val set2 = Module(new SET)
  val set3 = Module(new SET)

  val hit_num = WireInit(0.U(2.W))

  val ram_hot = Module(new Hotram)      //for replace
  val ramhot_wdata_r = RegInit(0.U(8.W))
  val ramhot_rdata_r = RegInit(0.U(8.W))
  val ramhot_wen_r   = RegInit(false.B)
  ram_hot.io.w_addr := icache_index(5,0)
  ram_hot.io.w_data := ramhot_wdata_r
  ram_hot.io.w_en   := ramhot_wen_r
  ram_hot.io.r_addr := icache_index(5,0)
  ramhot_rdata_r := ram_hot.io.r_data


  val write_set_r  = RegInit(0.U(4.W))
  val w_hotram_r   = RegInit(false.B)


  val state_r = RegInit(CacheStates.IDLE)

  val fetch_write_r = RegInit(0.U(4.W)) 
  val writedata  = WireInit(0.U(128.W))  
  val hit        = Wire(UInt(4.W))
  val miss       = WireInit(0.U(4.W))
  val valid      = WireInit(0.U(4.W))
  val rdata_set0 = WireInit(0.U(128.W))
  val rdata_set1 = WireInit(0.U(128.W))
  val rdata_set2 = WireInit(0.U(128.W))
  val rdata_set3 = WireInit(0.U(128.W))
  val read_valid_r = RegInit(false.B)
  val read_addr  = WireInit(0.U(32.W))
  val ram_en     = WireInit(0.U(4.W))
  val write0     = WireInit(false.B)
  val write1     = WireInit(false.B)
  val write2     = WireInit(false.B)
  val write3     = WireInit(false.B)

  val cache_rdata_valid = WireInit(false.B)
  val next_r_data   = RegInit(0.U(128.W))


  ram_en := Mux(fetch_write_r.orR, "b1111".U(4.W),
            Mux(read_addr(3,2) === "b00".U(2.W), "b0001".U(4.W),
            Mux(read_addr(3,2) === "b01".U(2.W), "b0010".U(4.W),
            Mux(read_addr(3,2) === "b10".U(2.W), "b0100".U(4.W),
             "b1000".U(4.W)))))

  hit_num := Mux(hit(0), 0.U,
             Mux(hit(1), 1.U,
             Mux(hit(2), 2.U,  3.U)))  




  write0 := Mux(fetch_write_r(0), true.B, write_set_r(0))
  write1 := Mux(fetch_write_r(1), true.B, write_set_r(1))
  write2 := Mux(fetch_write_r(2), true.B, write_set_r(2))
  write3 := Mux(fetch_write_r(3), true.B, write_set_r(3))

  val o_cpu_rdata = WireInit(0.U(32.W))

  writedata := Mux(fetch_write_r.orR & axi_r_last, Cat(axi_r_data ,next_r_data(95, 0)), 0.U(128.W)) 

  set0.io.icache_tag := icache_tag
  set1.io.icache_tag := icache_tag
  set2.io.icache_tag := icache_tag
  set3.io.icache_tag := icache_tag

  set0.io.icache_index := icache_index
  set1.io.icache_index := icache_index
  set2.io.icache_index := icache_index
  set3.io.icache_index := icache_index



  

  set0.io.w_addr := Mux(cache_clear, 0.U(6.W),icache_index(5,0))
  set1.io.w_addr := Mux(cache_clear, 0.U(6.W),icache_index(5,0))
  set2.io.w_addr := Mux(cache_clear, 0.U(6.W),icache_index(5,0))
  set3.io.w_addr := Mux(cache_clear, 0.U(6.W),icache_index(5,0))

  set0.io.w_data :=  Mux(cache_clear, 0.U ,writedata)
  set1.io.w_data :=  Mux(cache_clear, 0.U ,writedata)
  set2.io.w_data :=  Mux(cache_clear, 0.U ,writedata)
  set3.io.w_data :=  Mux(cache_clear, 0.U ,writedata)

  set0.io.w_en   := write0 & axi_r_last
  set1.io.w_en   := write1 & axi_r_last
  set2.io.w_en   := write2 & axi_r_last
  set3.io.w_en   := write3 & axi_r_last
  

  set0.io.r_addr := Mux(cache_clear, 0.U(6.W),icache_index(5,0))
  set1.io.r_addr := Mux(cache_clear, 0.U(6.W),icache_index(5,0))
  set2.io.r_addr := Mux(cache_clear, 0.U(6.W),icache_index(5,0))
  set3.io.r_addr := Mux(cache_clear, 0.U(6.W),icache_index(5,0))

  set0.io.read_miss := read_valid_r
  set1.io.read_miss := read_valid_r
  set2.io.read_miss := read_valid_r
  set3.io.read_miss := read_valid_r

  set0.io.write     := Mux(cache_clear ,false.B,write0)
  set1.io.write     := Mux(cache_clear ,false.B,write1)
  set2.io.write     := Mux(cache_clear ,false.B,write2)
  set3.io.write     := Mux(cache_clear ,false.B,write3)

  set0.io.ram_en := ram_en(0)
  set1.io.ram_en := ram_en(1)
  set2.io.ram_en := ram_en(2)
  set3.io.ram_en := ram_en(3)

  

  rdata_set0 := set0.io.r_data
  rdata_set1 := set1.io.r_data
  rdata_set2 := set2.io.r_data
  rdata_set3 := set3.io.r_data

  

  hit   := Cat(set3.io.hit,   set2.io.hit,   set1.io.hit,   set0.io.hit)
  valid := Cat(set3.io.valid, set2.io.valid, set1.io.valid, set0.io.valid)
  miss  := Cat(set3.io.miss,  set2.io.miss,  set1.io.miss,  set0.io.miss)
  
  val i = RegInit(0.U(3.W))
  val wait_buff = RegInit(0.U(32.W))
  read_addr   := cpu_r_addr
  read_valid_r  := cpu_r_valid

  val set_switch_data   = Mux(hit(0), rdata_set0,
                          Mux(hit(1), rdata_set1,
                          Mux(hit(2), rdata_set2, 
                          Mux(hit(3), rdata_set3, 
                          next_r_data))))

  switch(state_r){
    is(CacheStates.IDLE){
      state_r     :=  Mux(cache_clear, CacheStates.COMP,
                      Mux(cpu_r_valid, CacheStates.COMP,CacheStates.IDLE))
      write_set_r := 0.U(4.W)
      cache_rdata_valid := false.B

    }
    is(CacheStates.COMP){
      cache_hit  := cache_hit
      when (hit.orR && read_valid_r){ 
        state_r   :=  Mux(  cache_clear, CacheStates.COMP,CacheStates.HIT)
        ramhot_wdata_r := Mux(ramhot_rdata_r(1,0) === hit_num ,Cat(ramhot_rdata_r(1,0),ramhot_rdata_r(7,2)),
        Mux(ramhot_rdata_r(3,2) === hit_num, Cat(ramhot_rdata_r(3,2), Cat(ramhot_rdata_r(7,4), ramhot_rdata_r(1,0))),
        Mux(ramhot_rdata_r(5,4) === hit_num, Cat(ramhot_rdata_r(5,4), Cat(ramhot_rdata_r(7,6), ramhot_rdata_r(3,0))),
        ramhot_rdata_r)))   
        ramhot_wen_r := true.B

       
  
      }
      .elsewhen( !(valid(0) & valid(1) & valid(2) & valid(3))|| miss(ramhot_rdata_r(1,0))){ //!(&valid) 
        state_r   := Mux(  cache_clear, CacheStates.COMP,CacheStates.FETCH )
        icache_miss := icache_miss + 1.U(64.W)
        axi_ar_len := 3.U
        axi_ar_valid := Mux(cache_clear,false.B, true.B)
        axi_ar_addr := Mux(read_addr(3,2) === "b00".U(2.W) ,read_addr,
          Mux(read_addr(3,2) === "b01".U(2.W), read_addr - 4.U, 
          Mux(read_addr(3,2) === "b10".U(2.W), read_addr - 8.U ,
          read_addr - 12.U 
          )))


        when(!valid(0)){
          fetch_write_r := "b0001".U(4.W) 
          //  8'b11_10_01_00
          /*  第一个set（00）最近被访问  
              第二个set（01）是第二近被访问的
              第三个set（10）是第三近被访问的
              第四个set（11）是最久未被访问的     */
          ramhot_wdata_r := "b00100110".U(8.W)
          ramhot_wen_r := true.B
        }
        .elsewhen(!valid(1)){
          fetch_write_r := "b0010".U(4.W)
          ramhot_wdata_r := Mux(ramhot_rdata_r(1,0) === "b01".U(4.W) ,Cat(ramhot_rdata_r(1,0),ramhot_rdata_r(7,2)),
          Mux(ramhot_rdata_r(3,2) === "b01".U(4.W), Cat(ramhot_rdata_r(3,2), Cat(ramhot_rdata_r(7,4), ramhot_rdata_r(1,0))),
          Mux(ramhot_rdata_r(5,4) === "b01".U(4.W), Cat(ramhot_rdata_r(5,4), Cat(ramhot_rdata_r(7,6), ramhot_rdata_r(3,0))),
          ramhot_rdata_r)))   
          ramhot_wen_r := true.B
        }
        .elsewhen(!valid(2)){
          fetch_write_r := "b0100".U(4.W)
          ramhot_wdata_r := Mux(ramhot_rdata_r(1,0) === "b10".U(4.W) ,Cat(ramhot_rdata_r(1,0),ramhot_rdata_r(7,2)),
          Mux(ramhot_rdata_r(3,2) === "b10".U(4.W), Cat(ramhot_rdata_r(3,2), Cat(ramhot_rdata_r(7,4), ramhot_rdata_r(1,0))),
          Mux(ramhot_rdata_r(5,4) === "b10".U(4.W), Cat(ramhot_rdata_r(5,4), Cat(ramhot_rdata_r(7,6), ramhot_rdata_r(3,0))),
          ramhot_rdata_r)))   
          ramhot_wen_r := true.B
        }
        .elsewhen(!valid(3)){
          fetch_write_r := "b1000".U(4.W)
          ramhot_wdata_r := Mux(ramhot_rdata_r(1,0) === "b11".U(4.W) ,Cat(ramhot_rdata_r(1,0),ramhot_rdata_r(7,2)),
          Mux(ramhot_rdata_r(3,2) === "b11".U(4.W), Cat(ramhot_rdata_r(3,2), Cat(ramhot_rdata_r(7,4), ramhot_rdata_r(1,0))),
          Mux(ramhot_rdata_r(5,4) === "b11".U(4.W), Cat(ramhot_rdata_r(5,4), Cat(ramhot_rdata_r(7,6), ramhot_rdata_r(3,0))),
          ramhot_rdata_r)))   
          ramhot_wen_r := true.B
        }
        .elsewhen(miss(ramhot_rdata_r(1,0)).orR){
          fetch_write_r := MuxLookup(ramhot_rdata_r(1,0), 0.U(4.W), List(
            "b00".U(4.W) -> "b0001".U(4.W),
            "b01".U(4.W) -> "b0010".U(4.W),
            "b10".U(4.W) -> "b0100".U(4.W),
            "b11".U(4.W) -> "b1000".U(4.W)
          ))
          ramhot_wdata_r := Cat(ramhot_rdata_r(1,0), ramhot_rdata_r(7,2)) //将最近访问的缓存行编号置于最高位，其余的缓存行编号依次后移
          ramhot_wen_r := true.B
        }
      
      }
      .otherwise{
        fetch_write_r := MuxLookup(ramhot_rdata_r(1,0), 0.U(4.W), List(
          "b00".U(4.W) -> "b0001".U(4.W),
          "b01".U(4.W) -> "b0010".U(4.W),
          "b10".U(4.W) -> "b0100".U(4.W),
          "b11".U(4.W) -> "b1000".U(4.W)
        ))
        ramhot_wdata_r := Cat(ramhot_rdata_r(1,0), ramhot_rdata_r(7,2))
        ramhot_wen_r := true.B

      }
        

      


    }
    is(CacheStates.HIT){
      cache_hit :=  cache_hit +1.U(64.W) 
      w_hotram_r := false.B
      write_set_r := 0.U(4.W)
      state_r := Mux(  cache_clear,CacheStates.COMP, Mux (ifu_ready ,CacheStates.COMP, CacheStates.WAIT))
      cache_rdata_valid := Mux(  cache_clear,false.B,true.B)
      o_cpu_rdata := MuxLookup(read_addr(3,2), 0.U(32.W), List(
          "b00".U(2.W) -> set_switch_data(31    , 0),
          "b01".U(2.W) -> set_switch_data(32*2-1, 32),
          "b10".U(2.W) -> set_switch_data(32*3-1, 32*2) ,
          "b11".U(2.W) -> set_switch_data(32*4-1, 32*3)
        ))
        wait_buff := o_cpu_rdata
      

    }
    is(CacheStates.FETCH){
        fetch_write_r     := fetch_write_r
        state_r           := Mux( cache_clear , CacheStates.COMP ,
                              Mux( axi_r_last  , Mux( ifu_ready , CacheStates.COMP , CacheStates.WAIT ) ,CacheStates.FETCH ))
        cache_rdata_valid := Mux( cache_clear , false.B ,
                              Mux( axi_r_last,true.B, false.B))

        i := Mux(axi_r_last, 0.U(3.W), i+1.U(3.W))

        when( axi_r_ready | io.axi_r_ready ){
          next_r_data := MuxCase(next_r_data, Seq(
          (i === 0.U) -> Cat(next_r_data(127, 32), io.axi_r_data),
          (i === 1.U) -> Cat(next_r_data(127, 64), io.axi_r_data, next_r_data(31, 0)),
          (i === 2.U) -> Cat(next_r_data(127, 96), io.axi_r_data, next_r_data(63, 0)),
          (i === 3.U) -> Cat(io.axi_r_data, next_r_data(95, 0))
        ))
        o_cpu_rdata := 
          MuxLookup(read_addr(3,2), 0.U(32.W), List(
          "b00".U(2.W) -> next_r_data(31,0), 
          "b01".U(2.W) -> next_r_data(32*2-1,32),
          "b10".U(2.W) -> next_r_data(32*3-1,32*2),
          "b11".U(2.W) -> io.axi_r_data
        ))
           wait_buff := o_cpu_rdata

      }
        
    }
    is(CacheStates.WAIT){
      wait_buff := wait_buff
      state_r   :=  Mux(ifu_ready , CacheStates.COMP , CacheStates.WAIT )
      o_cpu_rdata := wait_buff 
      cache_rdata_valid := true.B


    }
  }

  io.o_cpu_rdata := o_cpu_rdata
  io.cache_valid := cache_rdata_valid

  io.axi_ar_valid := axi_ar_valid
  io.axi_ar_addr  := axi_ar_addr
  io.axi_ar_len   := axi_ar_len

  io.cache_hit    := cache_hit
  io.icache_miss  := icache_miss 

}