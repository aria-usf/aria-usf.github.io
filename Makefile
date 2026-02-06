artifact ?= site result
sentinel = .build.stamp

.PHONY: all clean

all: $(sentinel)

$(sentinel): haunt.scm $(wildcard posts/**/*)
	haunt build && touch $(sentinel)

clean:
	rm -rf $(artifact) $(sentinel)
