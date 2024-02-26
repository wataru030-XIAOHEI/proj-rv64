//================================================================
// file         : set 
// description  : 
// author       : Master
// version      : v0.0.0
// date         : 2023-12-9
//================================================================

package libs
import chisel3._
import chisel3.util._

class setIO extends  Bundle{

  val icache_tag    = Input(UInt(20.W))
  val icache_index  = Input(UInt(8.W))

  val w_addr        = Input(UInt(6.W))
  val w_data        = Input(UInt((32*4).W))
  val w_en          = Input(Bool())
  val r_addr        = Input(UInt(6.W))
  val read_miss     = Input(Bool())
  val write         = Input(Bool())
  val ram_en        = Input(UInt(4.W))

  val r_data        = Output(UInt(128.W))
  val hit           = Output(Bool())
  // val modify        = Output(Bool())
  val miss          = Output(Bool())
  val valid         = Output(Bool())
}

class SET extends Module {
  val io = IO(new setIO)

  val icache_tag = io.icache_tag
  val icache_index = io.icache_index

  val Ram_0 = Module(new SIMPLE_RAM)
  val Ram_1 = Module(new SIMPLE_RAM)
  val Ram_2 = Module(new SIMPLE_RAM)
  val Ram_3 = Module(new SIMPLE_RAM)

  val index_0 = (io.icache_index(7) === 0.U  && io.icache_index(6) === 0.U) 
  val index_1 = (io.icache_index(7) === 0.U  && io.icache_index(6) === 1.U)
  val index_2 = (io.icache_index(7) === 1.U  && io.icache_index(6) === 0.U)
  val index_3 = (io.icache_index(7) === 1.U  && io.icache_index(6) === 1.U)

  val tagram = Module(new TAGRAM)
  val tagram_rdata = WireInit (0.U(22.W))
  val write_tag_data = WireInit(0.U(22.W)) 
  val read_miss = io.read_miss
  val ram_en    = io.ram_en
      

  val tagram_waddr = Mux(index_0 , io.w_addr ,
                     Mux(index_1 , io.w_addr + 64.U(8.W) ,
                     Mux(index_2 , io.w_addr + 128.U(8.W) ,
                     Mux(index_3 , io.w_addr + 192.U(8.W) , 0.U))))

  val tagram_raddr = Mux(index_0 , io.r_addr ,
                     Mux(index_1 , io.r_addr + 64.U(8.W) ,
                     Mux(index_2 , io.r_addr + 128.U(8.W) ,
                     Mux(index_3 , io.r_addr + 192.U(8.W) , 0.U))))

  tagram_rdata := tagram.io.r_data
  tagram.io.w_addr := tagram_waddr
  tagram.io.w_en :=  io.write
  tagram.io.w_data := write_tag_data
  tagram.io.r_addr := tagram_raddr

  
  val dirty = tagram_rdata(21)
  val valid = tagram_rdata(20)
  val tagram_tag = tagram_rdata(19,0)

  val hit     = valid && (icache_tag === tagram_tag)
  val modify  = valid && (icache_tag =/= tagram_tag) && dirty
  val miss    = !valid || ((icache_tag =/= tagram_tag) && !dirty) 

  write_tag_data := Mux(read_miss, Cat("b01".U(2.W), icache_tag),
        Mux((modify || miss ), Cat("b11".U(2.W), icache_tag), 
        Cat("b11".U(2.W), tagram_tag) ) )

  val rdata0_r = WireInit(0.U(128.W))
  val rdata1_r = WireInit(0.U(128.W))
  val rdata2_r = WireInit(0.U(128.W))
  val rdata3_r = WireInit(0.U(128.W))

  

  Ram_0.io.r_addr := io.r_addr
  Ram_0.io.w_addr := io.w_addr
  Ram_0.io.w_data := io.w_data
  Ram_0.io.w_en := io.w_en  &&  index_0  
  rdata0_r := Ram_0.io.r_data

  Ram_1.io.r_addr := io.r_addr
  Ram_1.io.w_addr := io.w_addr
  Ram_1.io.w_data := io.w_data
  Ram_1.io.w_en := io.w_en  &&  index_1  
  rdata1_r := Ram_1.io.r_data

  Ram_2.io.r_addr := io.r_addr
  Ram_2.io.w_addr := io.w_addr
  Ram_2.io.w_data := io.w_data
  Ram_2.io.w_en := io.w_en  &&  index_2  
  rdata2_r := Ram_2.io.r_data

  Ram_3.io.r_addr := io.r_addr
  Ram_3.io.w_addr := io.w_addr
  Ram_3.io.w_data := io.w_data
  Ram_3.io.w_en := io.w_en  &&  index_3  
  rdata3_r := Ram_3.io.r_data

  val rdata = Mux(index_0, rdata0_r,
              Mux(index_1, rdata1_r,
              Mux(index_2, rdata2_r,
              Mux(index_3, rdata3_r, 
              0.U(128.W)  ) )))

  io.r_data :=  rdata
  io.hit    :=  hit

  io.miss   :=  miss
  io.valid  :=  valid

}