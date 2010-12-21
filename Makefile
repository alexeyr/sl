REBAR=./rebar
REBAR_COMPILE=$(REBAR) get-deps compile
PLT=dialyzer/sl.plt

all: compile

compile:
	$(REBAR_COMPILE)

test:
	$(REBAR_COMPILE) eunit

clean:
	-rm -rf deps ebin/* priv/* doc/* .eunit c_src/*.o

docs:
	$(REBAR_COMPILE) doc

static:
	$(REBAR_COMPILE)
ifeq ($(wildcard $(PLT)),)
	dialyzer --build_plt --apps kernel stdlib erts --output_plt $(PLT) 
else
	mkdir -p dyalyzer
	dialyzer --plt $(PLT) -r ebin
endif

cross_compile: clean
	$(REBAR_COMPILE) -C rebar.cross_compile.config

.PHONY: all compile test clean docs static cross_compile
