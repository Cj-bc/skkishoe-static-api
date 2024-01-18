DICTIONARIES ?= SKK-JISYO.L
DST := "."

.PHONY: build

build: convert.awk dict
	./convert.awk -v dst="$(DST)/midashi/" $(foreach d,$(DICTIONARIES),dict/$(d).utf-8)

dict:
	git clone --depth=1 https://github.com/skk-dev/dict
	for f in $(DICTIONARIES); do nkf -w8 dict/$f > dict/${f}.utf-8; done
