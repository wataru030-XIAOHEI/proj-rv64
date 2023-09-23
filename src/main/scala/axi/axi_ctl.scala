package axi

import chisel3._ 
import chisel3.util._ 
import dataclass.data
import bus.{data_channel, b_channel, address_chl, axi_chl_param}

class adr_chl(AW:Int) extends Bundle {
    val adr = UInt(AW.W)
    val en  = Bool()
}

class dat_chl(DW:Int) extends Bundle {
    val dat = UInt(DW.W)
    val strb = UInt((DW/8).W)
}

class axi_r_ctl_io (implicit p:axi_chl_param) extends Bundle{
    val axi_ar = Flipped(Decoupled(new address_chl(p)))
    val axi_r  = Decoupled(new data_channel(p))

    val adr = Output(new adr_chl(p.AW))
    val dat = Flipped(Valid(new dat_chl(p.DW)))
}

abstract class axi_r_ctl_base(implicit p :axi_chl_param) extends Module {
    val io = IO(new axi_r_ctl_io()(p))
}

class axi_r_ctl(DP:Int)(implicit p :axi_chl_param) extends axi_r_ctl_base()(p) {
    require(DP>0,s"This AXI_r_ctl's depth must be > 0 (current DP = ${DP})")

    val arack = io.axi_ar.valid & io.axi_ar.ready
    val ar_fifo = Module(new axi_fifo(chiselTypeOf(io.axi_ar.bits),DP))
    val ar_ready_r = RegInit(false.B)

    when(arack){
        ar_ready_r := false.B
    }.elsewhen(io.axi_ar.valid){
        ar_ready_r := ar_fifo.io.wr.ready
    }
    io.axi_ar.ready := ar_ready_r

    ar_fifo.io.wr.valid := arack 
    ar_fifo.io.wr.bits := io.axi_ar.bits

    val rdat_cnt_r = RegInit(0.U(log2Ceil(p.LENW).W))
    val rdat_cnt_in = Wire(UInt(rdat_cnt_r.getWidth.W))

    val fix_md  = ar_fifo.io.rd.bits.burst === "b00".U
    val wrap_md = ar_fifo.io.rd.bits.burst === "b10".U 
    val incr_md = ar_fifo.io.rd.bits.burst === "b01".U
    val burst_start =  fix_md | wrap_md | incr_md 

    val fix_adr  = ar_fifo.io.rd.bits.addr
    val wrap_adr = Cat(ar_fifo.io.rd.bits.addr(p.AW-1,p.LENW),0.U((p.LENW).W)) + rdat_cnt_r
    val incr_adr= ar_fifo.io.rd.bits.addr + rdat_cnt_r

    val rack  = io.axi_r.valid & io.axi_r.ready 
    val rend  = rack & io.axi_r.bits.last
    val rlast = rdat_cnt_r === ar_fifo.io.rd.bits.len 
    val rresp = Fill(2,rlast) & "b00".U 
    val re    = ar_fifo.io.rd.valid

    when(rend){
        rdat_cnt_r := 0.U
    }.elsewhen(burst_start){
        rdat_cnt_r := rdat_cnt_in
    }

    rdat_cnt_in := Mux(rack,rdat_cnt_r + 1.U ,rdat_cnt_r)

    io.adr.adr := MuxCase(0.U,Seq(
        fix_md  -> fix_adr ,
        wrap_md -> wrap_adr ,
        incr_md -> incr_adr 
    ))

    io.adr.en := re 
    io.axi_r.valid     := io.dat.valid
    io.axi_r.bits.data := Mux(io.axi_r.valid,io.dat.bits.dat,0.U)
    io.axi_r.bits.last := rlast & io.axi_r.valid
    io.axi_r.bits.id   := Mux(io.axi_r.valid,ar_fifo.io.rd.bits.id,0.U)
    io.axi_r.bits.resp := 0.U //Mux(io.axi_r.valid,rresp,0.U)
    io.axi_r.bits.strb := 0.U

    //release fifo 
    ar_fifo.io.rd.ready := rend
}


class axi_w_ctl_io(implicit p : axi_chl_param) extends Bundle {
    val axi_aw = Flipped(Decoupled(new address_chl(p)))
    val axi_w  = Flipped(Decoupled(new data_channel(p)))
    val axi_b  = Decoupled(new b_channel(p))

    val adr = Output(new adr_chl(p.AW))
    val dat = Valid(new dat_chl(p.DW))
    val free = Input(Bool())
}

abstract class axi_w_ctl_base(implicit p : axi_chl_param) extends Module {
    val io = IO(new axi_w_ctl_io)
}

class axi_w_ctl(DP:Int)(implicit p :axi_chl_param) extends axi_w_ctl_base()(p) {
    require(DP>0,s"This AXI_w_ctl's depth must be > 0 (current DP = ${DP})")

    val awack = io.axi_aw.valid & io.axi_aw.ready
    val aw_fifo = Module(new axi_fifo(chiselTypeOf(io.axi_aw.bits),DP))
    val b_fifo  = Module(new axi_fifo(Bool(),DP))
    val aw_ready_r = RegInit(false.B)

    when(awack){
        aw_ready_r := false.B
    }.elsewhen(io.axi_aw.valid){
        aw_ready_r := aw_fifo.io.wr.ready
    }
    io.axi_aw.ready := aw_ready_r

    aw_fifo.io.wr.valid := awack 
    aw_fifo.io.wr.bits := io.axi_aw.bits
    b_fifo.io.wr.valid := awack 
    b_fifo.io.wr.bits := true.B

    val wdat_cnt_r = RegInit(0.U(log2Ceil(p.LENW).W))
    val wdat_cnt_in = Wire(UInt(wdat_cnt_r.getWidth.W))

    val fix_md  = aw_fifo.io.rd.bits.burst === "b00".U
    val wrap_md = aw_fifo.io.rd.bits.burst === "b10".U 
    val incr_md = aw_fifo.io.rd.bits.burst === "b01".U
    val burst_start =  fix_md | wrap_md | incr_md 

    val fix_adr  = aw_fifo.io.rd.bits.addr
    val wrap_adr = Cat(aw_fifo.io.rd.bits.addr(p.AW-1,p.LENW),0.U((p.LENW).W)) + wdat_cnt_r
    val incr_adr= aw_fifo.io.rd.bits.addr + wdat_cnt_r


    val wack = io.axi_w.valid & io.axi_w.ready
    val wend = wack & io.axi_w.bits.last

    val back = io.axi_b.valid & io.axi_b.ready


   val bid_r    = RegInit(0.U(p.IDW.W))
   val bresp_r  = RegInit(0.U(2.W))
   val bvalid_r = RegInit(false.B)

   when(wend){
    bvalid_r := true.B 
    bid_r    := aw_fifo.io.rd.bits.id
    bresp_r  := "b00".U
   }.elsewhen(back){
    bvalid_r := false.B 
    bid_r    := 0.U
    bresp_r  := 0.U 
   }

   when(wend){
    wdat_cnt_r := 0.U
   }.elsewhen(burst_start){
    wdat_cnt_r := wdat_cnt_in
   }
   wdat_cnt_in := Mux(wack,wdat_cnt_r + 1.U ,wdat_cnt_r)

   io.adr.adr := MuxCase(0.U,Seq(
    fix_md -> fix_adr ,
    incr_md -> incr_adr ,
    wrap_md -> wrap_adr
   ))

   io.adr.en := io.axi_w.valid

   io.dat.bits.strb := io.axi_w.bits.strb
   io.dat.bits.dat  := io.axi_w.bits.data 
   io.dat.valid     := io.axi_w.valid
   io.axi_w.ready   := io.free 

   io.axi_b.valid   := bvalid_r
   io.axi_b.bits.id := bid_r
   io.axi_b.bits.resp := bresp_r

   //release fifo 
   aw_fifo.io.rd.ready := wend
   b_fifo.io.rd.ready  := back


}