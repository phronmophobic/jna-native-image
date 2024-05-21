SHELL := bash

ROOT := $(shell pwd)

HISTORY := /tmp/docker-bash-history


default:

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
	$(RM) -r .cpcache/ target

$(HISTORY):
	mkdir $@
