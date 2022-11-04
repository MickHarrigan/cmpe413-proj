CADENCE = ~/cmpe413/cadence
SCRIPTS = scripts

FILES_CACHE = cache/cache_cell_1bit.vhd cache/cache_decoder.vhd \
	primitives/and2.vhd primitives/Dlatch.vhd primitives/inverter.vhd primitives/tx.vhd


cache_cell_1bit: $(FILES_CACHE)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_CACHE)

alu_4_tb: alu_4_tb.vhd $(FILES_ALU_4)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder alu_4_tb.vhd

	$(CADENCE)/run_ncelab.bash -messages -access rwc -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var alu_4_tb

	$(CADENCE)/run_ncsim.bash -input ncsim.run -messages -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var alu_4_tb
		