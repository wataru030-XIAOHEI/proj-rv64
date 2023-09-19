
SIM_TOOL = iverilog

VER = -g2005-sv


sim:
	$(SIM_TOOL) $(VER) -I ../sim -o ./wave ./../sim/*.v ./../src/*.v
	./wave 



gui:
	gtkwave ./wave.vcd



run: sim gui
