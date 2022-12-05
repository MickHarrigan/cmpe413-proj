CADENCE = ~/cmpe413/cadence
SCRIPTS = scripts
TESTBENCHES = testbenches

FILES_PRIMITIVES = src/primitives/*
FILES_BASICS = src/basics/* $(FILES_PRIMITIVES)
FILES_CACHE = src/cache/* $(FILES_BASICS)
FILES_CONTROL = src/control/* $(FILES_BASICS) $(FILES_CACHE)
FILES_COUNTER = src/counter/* $(FILES_BASICS)
FILES_CHIP = src/chip.vhd $(FILES_BASICS) $(FILES_CACHE) $(FILES_CONTROL) $(FILES_COUNTER)

default: chip_test

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

control: $(FILES_CONTROL)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_CONTROL)

counter: $(FILES_COUNTER)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_COUNTER)

chip: $(FILES_CHIP)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(FILES_CHIP)


# Testbenches

chip_test: $(TESTBENCHES)/example_test1/chip_test.vhd $(FILES_CHIP)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(TESTBENCHES)/example_test1/chip_test.vhd

#	$(CADENCE)/run_ncelab.bash -messages -access rwc -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var chip_test

#	$(CADENCE)/run_ncsim.bash -input $(TESTBENCHES)/example_test1/run.ncsim -messages -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var chip_test

chip_test_gui:
	$(CADENCE)/run_ncsim.bash -gui -messages -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var chip_test

statemachine_tb: $(TESTBENCHES)/example_test1/statemachine_tb.vhd $(FILES_CONTROL)
	$(CADENCE)/run_ncvhdl.bash -messages -linedebug -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var -smartorder $(TESTBENCHES)/statemachine_tb/statemachine_tb.vhd

	$(CADENCE)/run_ncelab.bash -messages -access rwc -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var statemachine_tb

	$(CADENCE)/run_ncsim.bash -input $(TESTBENCHES)/statemachine_tb/run.ncsim -messages -cdslib $(CADENCE)/cds.lib \
		-hdlvar $(CADENCE)/hdl.var statemachine_tb


# Quality of life

clean:
	rm -f *.log
