SHELL := bash

ROOT := $(shell pwd)

HISTORY := /tmp/docker-bash-history

SOURCES := \
    compile.sh \
    $(shell find src -type f) \

CONFIGS := \
  config/jni-config.json \
  config/resource-config.json \
  config/reflect-config.json \

RAPIDYAML_LIBRARY := /usr/lib/x86_64-linux-gnu/librapidyaml.so

YAMLSCRIPT_REPO := https://github.com/yaml/yamlscript

default:

run: build
	target/jna

build: target/jna $(RAPIDYAML_LIBRARY)

clean:
	$(RM) -r .cpcache/ target $(CONFIGS)

realclean: clean
	$(RM) -r yamlscript

sysclean:
	$(RM) $(RAPIDYAML_LIBRARY)

target/jna: compile.sh $(CONFIGS) target/jna-0.1.0-standalone.jar
	bash $<

config/%.json: config/%.yaml
	ys -J $< > $@

target/jna-0.1.0-standalone.jar: $(SOURCES)
	clojure -T:build uber

# Try this repo in Docker per the README instructions:
test:
	docker run --rm -it \
	    -v $(ROOT):/repo \
	    clojure bash docker.sh

# Same as above but stay in a Bash shell after:
test-shell: $(HISTORY)
	docker run --rm -it \
	    -v $(ROOT):/repo \
	    -v $(ROOT)/docker.sh:/root/.profile \
	    -v $<:/root/.bash_history \
	    clojure bash -l

$(RAPIDYAML_LIBRARY): rapidyaml/native/librapidyaml.so.0.6.0
	mv $< $@

rapidyaml/native/librapidyaml.so.0.6.0: yamlscript
	$(MAKE) -C $</rapidyaml build

force: yamlscript
	$(MAKE) -C $</rapidyaml build

yamlscript:
	git clone --depth=1 --branch=rapidyaml $(YAMLSCRIPT_REPO) $@

$(HISTORY):
	mkdir $@
