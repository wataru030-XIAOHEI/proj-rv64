circuit sram_model :
  module snyc_sram_model :
    input clock : Clock
    input reset : Reset
    output io : { flip adr : UInt<8>, flip cen : UInt<1>, flip wen : UInt<1>, flip wstrb : UInt<4>, flip d : UInt<32>, q : UInt<32>}

    cmem mem : UInt<32> [256] @[sram_model.scala 90:18]
    node _re_T = eq(io.cen, UInt<1>("h0")) @[sram_model.scala 95:15]
    node re = and(_re_T, io.wen) @[sram_model.scala 95:23]
    node _we_T = eq(io.cen, UInt<1>("h0")) @[sram_model.scala 96:15]
    node _we_T_1 = eq(io.wen, UInt<1>("h0")) @[sram_model.scala 96:25]
    node we = and(_we_T, _we_T_1) @[sram_model.scala 96:23]
    reg rdat_dly : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[sram_model.scala 99:27]
    when re : @[sram_model.scala 100:15]
      read mport rdat_dly_MPORT = mem[io.adr], clock @[sram_model.scala 100:37]
      rdat_dly <= rdat_dly_MPORT @[sram_model.scala 100:26]
    else :
      rdat_dly <= UInt<32>("h0") @[sram_model.scala 101:26]
    io.q <= rdat_dly @[sram_model.scala 103:10]
    read mport wr_rd_pre = mem[io.adr], clock @[sram_model.scala 105:29]
    wire wr_pre : UInt<32> @[sram_model.scala 106:22]
    node _wr_pre_T = bits(io.wstrb, 0, 0) @[sram_model.scala 109:39]
    node _wr_pre_T_1 = and(we, _wr_pre_T) @[sram_model.scala 109:29]
    node _wr_pre_T_2 = bits(io.d, 7, 0) @[sram_model.scala 109:47]
    node _wr_pre_T_3 = bits(wr_rd_pre, 7, 0) @[sram_model.scala 109:72]
    node _wr_pre_T_4 = mux(_wr_pre_T_1, _wr_pre_T_2, _wr_pre_T_3) @[sram_model.scala 109:25]
    node _wr_pre_T_5 = bits(io.wstrb, 1, 1) @[sram_model.scala 109:39]
    node _wr_pre_T_6 = and(we, _wr_pre_T_5) @[sram_model.scala 109:29]
    node _wr_pre_T_7 = bits(io.d, 15, 8) @[sram_model.scala 109:47]
    node _wr_pre_T_8 = bits(wr_rd_pre, 15, 8) @[sram_model.scala 109:72]
    node _wr_pre_T_9 = mux(_wr_pre_T_6, _wr_pre_T_7, _wr_pre_T_8) @[sram_model.scala 109:25]
    node _wr_pre_T_10 = bits(io.wstrb, 2, 2) @[sram_model.scala 109:39]
    node _wr_pre_T_11 = and(we, _wr_pre_T_10) @[sram_model.scala 109:29]
    node _wr_pre_T_12 = bits(io.d, 23, 16) @[sram_model.scala 109:47]
    node _wr_pre_T_13 = bits(wr_rd_pre, 23, 16) @[sram_model.scala 109:72]
    node _wr_pre_T_14 = mux(_wr_pre_T_11, _wr_pre_T_12, _wr_pre_T_13) @[sram_model.scala 109:25]
    node _wr_pre_T_15 = bits(io.wstrb, 3, 3) @[sram_model.scala 109:39]
    node _wr_pre_T_16 = and(we, _wr_pre_T_15) @[sram_model.scala 109:29]
    node _wr_pre_T_17 = bits(io.d, 31, 24) @[sram_model.scala 109:47]
    node _wr_pre_T_18 = bits(wr_rd_pre, 31, 24) @[sram_model.scala 109:72]
    node _wr_pre_T_19 = mux(_wr_pre_T_16, _wr_pre_T_17, _wr_pre_T_18) @[sram_model.scala 109:25]
    node wr_pre_lo = cat(_wr_pre_T_9, _wr_pre_T_4) @[Cat.scala 33:92]
    node wr_pre_hi = cat(_wr_pre_T_19, _wr_pre_T_14) @[Cat.scala 33:92]
    node _wr_pre_T_20 = cat(wr_pre_hi, wr_pre_lo) @[Cat.scala 33:92]
    wr_pre <= _wr_pre_T_20 @[sram_model.scala 108:12]
    when we : @[sram_model.scala 113:13]
      write mport MPORT = mem[io.adr], clock
      MPORT <= wr_pre
    wire rv : UInt<1> @[sram_model.scala 117:22]
    wire wv : UInt<1> @[sram_model.scala 118:22]
    rv <= re @[sram_model.scala 119:12]
    wv <= we @[sram_model.scala 120:12]
    when rv : @[sram_model.scala 121:17]
      node _T = asUInt(reset) @[sram_model.scala 122:19]
      node _T_1 = eq(_T, UInt<1>("h0")) @[sram_model.scala 122:19]
      when _T_1 : @[sram_model.scala 122:19]
        printf(clock, UInt<1>("h1"), "rd mem[0x%x] => 0x%x\n", io.adr, io.q) : printf @[sram_model.scala 122:19]
    when wv : @[sram_model.scala 124:17]
      node _T_2 = asUInt(reset) @[sram_model.scala 125:19]
      node _T_3 = eq(_T_2, UInt<1>("h0")) @[sram_model.scala 125:19]
      when _T_3 : @[sram_model.scala 125:19]
        printf(clock, UInt<1>("h1"), "wr mem[0x%x] := 0x%x", io.adr, io.d) : printf_1 @[sram_model.scala 125:19]
      node _T_4 = asUInt(reset) @[sram_model.scala 126:19]
      node _T_5 = eq(_T_4, UInt<1>("h0")) @[sram_model.scala 126:19]
      when _T_5 : @[sram_model.scala 126:19]
        printf(clock, UInt<1>("h1"), "  wstrb : 0x%x\n", io.wstrb) : printf_2 @[sram_model.scala 126:19]


  module sram_model :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip adr : UInt<8>, flip cen : UInt<1>, flip wen : UInt<1>, flip wstrb : UInt<4>, flip d : UInt<32>, q : UInt<32>}

    inst mem of snyc_sram_model @[sram_model.scala 149:25]
    mem.clock <= clock
    mem.reset <= reset
    io.q <= mem.io.q @[sram_model.scala 150:16]
    mem.io.d <= io.d @[sram_model.scala 150:16]
    mem.io.wstrb <= io.wstrb @[sram_model.scala 150:16]
    mem.io.wen <= io.wen @[sram_model.scala 150:16]
    mem.io.cen <= io.cen @[sram_model.scala 150:16]
    mem.io.adr <= io.adr @[sram_model.scala 150:16]

