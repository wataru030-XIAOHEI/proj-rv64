module testbench();

reg clock ;
reg reset;
reg icu_ack;

initial clock = 0;

initial forever #10 clock = ~clock;
initial begin
    reset = 1'b1;
    #200;
    reset = 1'b0;
end
initial begin 
    icu_ack = 1'b0;
    #100;
    icu_ack = 1'b1;
end 
//Instance 
fetch_2stages fetch_2stages(
  .clock(clock),
  .reset(reset),
  .io_l0_restart_bus_branch_bus_vld(1'b0),
  .io_l0_restart_bus_branch_bus_adr(),
  .io_l0_fe_br_bus_branch_bus_vld(1'b0),
  .io_l0_fe_br_bus_branch_bus_adr(),
  .io_l0_be_br_bus_branch_bus_vld(1'b0),
  .io_l0_be_br_bus_branch_bus_adr(),
  .io_l0_fetch_bus_req(),
  .io_l0_fetch_bus_adr(),
  .io_l0_fetch_bus_nadr(),
  .io_l0_fetch_bus_ack(icu_ack),
  .io_l1_bpu_bus_req(),
  .io_l1_bpu_bus_adr(),
  .io_l1_bpu_bus_nadr(),
  .io_l1_bpu_bus_ack(1'b1),
  .out_ready(1'b1),
  .out_valid(),
  .out_pc()
);


initial begin            
    $dumpfile("wave.vcd");        
    $dumpvars(0, testbench);    
    #50000 $finish;
end

endmodule  //TOP
