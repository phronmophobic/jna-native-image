SHELL := bash

ROOT := $(shell pwd)

HISTORY := /tmp/docker-bash-history

SOURCES := \
    Makefile \
    compile.sh \
    $(wildcard *.json) \

CONFIGS := \
  config/jni-config.json \
  config/resource-config.json \
  config/reflect-config.json \

default:

run: build
	target/jna

build: target/jna

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

clean:
	$(RM) -r .cpcache/ target $(CONFIGS)

$(HISTORY):
	mkdir $@
