# Package Name
PACKNAME  = Project_7_Segment_Top
MODULES   = Binary_To_7Segment Debounce_Switch

# Use local tools
#GHDL      = ghdl
#GHDLSYNTH = ghdl.so
#YOSYS     = yosys
#NEXTPNR   = nextpnr-ice40
#ICEPACK   = icepack
#ICEPROG   = iceprog

# Use Docker images
DOCKER=docker
#DOCKER=podman
#
PWD = $(shell pwd)
DOCKERARGS = run --rm -v $(PWD):/src -w /src
#
GHDL      = $(DOCKER) $(DOCKERARGS) ghdl/synth:beta ghdl
GHDLSYNTH = ghdl
YOSYS     = $(DOCKER) $(DOCKERARGS) ghdl/synth:beta yosys
NEXTPNR   = $(DOCKER) $(DOCKERARGS) ghdl/synth:nextpnr-ice40 nextpnr-ice40
ICEPACK   = $(DOCKER) $(DOCKERARGS) hdlc/icestorm icepack
ICEPROG   = iceprog

            #### DO NOT MODIFY ANYTHING BELOW THIS LINE ###

# GO BOARD GENERICS
GHDL_GENERICS= #-gCLK_FREQUENCY=25000000
PCF=constraints/goboard.pcf
PACKAGE=vq100
DEVICE=--hx1k
FREQ=--freq 25

all: $(PACKNAME).bin

# Take all out modules and append .vhdl to the module name
# As an example, Foo will turn into Foo.vhdl
SOURCES = $(MODULES:%=%.vhdl) $(PACKNAME).vhdl

$(PACKNAME).json: $(SOURCES)
	$(GHDL) -a --std=08 $^ 
	$(YOSYS) -m $(GHDLSYNTH) -p "ghdl --std=08 $(GHDL_GENERICS) $(SOURCES) -e $(PACKNAME); synth_ice40 -json $@"

$(PACKNAME).asc: $(PACKNAME).json $(LPF)
	$(NEXTPNR) --hx1k --json $< $(FREQ) --pcf $(PCF) --pcf-allow-unconstrained --package $(PACKAGE) --asc $@

$(PACKNAME).bin: $(PACKNAME).asc
	$(ICEPACK) $< $@

prog: $(PACKNAME).bin
	$(ICEPROG) $<

clean:
	@rm -f work-obj08.cf *.bit *.json *.svf *.config

.PHONY: clean prog
.PRECIOUS: *.json *.asc *.bin
