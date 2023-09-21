
SIM_TOOL = iverilog

VER = -g2012


clean:
	@rm -rf ./*.log 
	@rm -rf flist 


genlist: clean
	@find ../sim -name "*.v" -or -name "*.sv" >> ./flist
	@find ../src -name "*.v" -or -name "*.sv" >> ./flist

sim: clean genlist
	@$(SIM_TOOL) $(VER) -I ../sim -o ./wave  -f ../run/flist  
	vvp -n ./wave -l err.log | tee sim.log



gui:
	gtkwave ./wave.vcd



run: sim gui
