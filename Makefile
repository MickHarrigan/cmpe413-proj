CADENCE = ~/cmpe413/cadence
SCRIPTS = scripts

FILES_CHIP = chip.vhd
FILES_CACHE = cache/* primitives/*

chip: $(FILES_CHIP)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_CHIP)

cache: $(FILES_CACHE)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_CACHE)

#alu_4_tb: alu_4_tb.vhd $(FILES_ALU_4)
#	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
#		-hdlvar $(CADENCE)/hdl.var -smartorder alu_4_tb.vhd
#
#	$(CADENCE)/run_ncelab.bash -messages -access rwc -cdslib $(CADENCE)/cds.lib \
#		-hdlvar $(CADENCE)/hdl.var alu_4_tb
#
#	$(CADENCE)/run_ncsim.bash -input ncsim.run -messages -cdslib $(CADENCE)/cds.lib \
#		-hdlvar $(CADENCE)/hdl.var alu_4_tb
		