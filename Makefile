DICTIONARIES ?= SKK-JISYO.L

.PHONY: build

dict: git
	git clone --depth=1 https://github.com/skk-dev/dict
	for f in $(DICTIONARIES); do nkf -w8 dict/$f > dict/${f}.utf-8; done

build: nkf convert.awk dict
	./convert.awk -v dst="out/midashi/" $(foreach d,$(DICTIONARIES),dict/$(d).utf-8)