class transaction ;
    rand bit wr_vad , rd_rdy ;
    rand bit [31:0] wr_dat   ;

    function void wr_display();
        $display("wr data : %08h",wr_dat);
    endfunction
endclass


class drv ;
    rand transaction tr ;
    virtual fifo_if vif ;

    function new(virtual fifo_if vif);
        this.vif = vif ;
    endfunction

    task run();
        for(int i = 0 ; i < 32 ; i++)begin
            vif.io_wr_valid = tr.wr_vad ;
            vif.io_rd_ready = tr.rd_rdy ;
            vif.io_wr_bits  = tr.wr_dat ;
            tr.wr_display();
            @(vif.clk);
            $display("rd data : %08h" , vif.io_rd_bits);

        end
    endtask

endclass



program automatic fifo_test(fifo_if itf);

    drv drv ;

    initial begin 
        drv = new(itf);
    end

    initial begin 
    @(negedge itf.rst);
    drv.run();
    end
endprogram


