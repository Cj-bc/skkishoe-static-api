DICTIONARIES ?= SKK-JISYO.L
DST ?= "./midashi"
TEMPDIR := $(shell mktemp -d)

.PHONY: build

build: convert.awk
	for f in $(DICTIONARIES); do nkf -w8 $$f > $(TEMPDIR)/$${f##*/}.utf-8; done
	gawk -f ./convert.awk -v dst="$(DST)/" $(TEMPDIR)/*
	rm -r $(TEMPDIR)
