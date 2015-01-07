REBAR?=rebar
DIALYZER?=dialyzer
PLT=.iso8601.plt

all: build

dev: devbuild

clean:
	$(REBAR) clean

distclean: clean
	@rm -rf deps

build: deps
	$(REBAR) compile

deps:
	$(REBAR) get-deps

test:
	$(REBAR) skip_deps=true eunit

dialyzer: $(PLT) devbuild
	$(DIALYZER) --plts $(PLT) -r ebin

$(PLT):
	$(DIALYZER) --build_plt $(DIALYZER_DEPS) --apps $(ERLANG_APPS) --output_plt $(PLT)
