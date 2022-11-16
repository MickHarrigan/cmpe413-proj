CADENCE = ~/cmpe413/cadence
SCRIPTS = scripts
TESTBENCHES = testbenches

FILES_PRIMITIVES = src/primitives/*
FILES_BASICS = src/basics/* $(FILES_PRIMITIVES)
FILES_CACHE = src/cache/* $(FILES_BASICS)
FILES_COUNTER = src/counter/* $(FILES_BASICS)
FILES_STATEMACHINE = src/statemachine/* $(FILES_BASICS)
FILES_CHIP = src/chip.vhd

# Designs

primitives: $(FILES_PRIMITIVES)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_PRIMITIVES)

basics: $(FILES_BASICS)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_BASICS)

cache: $(FILES_CACHE)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_CACHE)

counter: $(FILES_COUNTER)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_COUNTER)

statemachine: $(FILES_STATEMACHINE)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_STATEMACHINE)

chip: $(FILES_CHIP)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_CHIP)


# Testbenches

#dffer_tb: TESTBENCHES/dffer_tb.vhd $(FILES_BASICS)
#	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
#		-hdlvar $(CADENCE)/hdl.var -smartorder dffer_tb.vhd
#
#	$(CADENCE)/run_ncelab.bash -messages -access rwc -cdslib $(CADENCE)/cds.lib \
#		-hdlvar $(CADENCE)/hdl.var dffer_tb
#
#	$(CADENCE)/run_ncsim.bash -input ncsim.run -messages -cdslib $(CADENCE)/cds.lib \
#		-hdlvar $(CADENCE)/hdl.var dffer_tb


# Quality of life

clean:
	rm -f *.log