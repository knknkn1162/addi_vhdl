GHDLC=ghdl
WORKDIR=.
FLAGS=--warn-error --workdir=${WORKDIR}/
#TB_OPTION=--assert-level=error
MODULES=\
	flopr \
	flopr_en \
	decoder \
	enable_generator \
	disp \
	regfile \
	datapath \
	addi
TESTS=\
	flopr \
	flopr_en \
	enable_generator \
	regfile \
	datapath
OBJS=$(addsuffix .o, ${MODULES})
TESTBENCHES=$(addsuffix _tb, ${TESTS})


.PHONY: all clean open
# disable CC commmand
.SUFFIXES:

all: $(OBJS) $(TESTBENCHES)
clean:
	rm -rf *.vcd *.o work-obj93.cf
open:
	open out.vcd

%_tb: %_tb.o %.o
	$(GHDLC) -e $(FLAGS) $@
	$(GHDLC) -r ${FLAGS} $@ --vcd=${WORKDIR}/out_$@.vcd ${TB_OPTION}

%: %.o
	# do nothing

%.o: %.vhdl
	$(GHDLC) -a $(FLAGS) $<
