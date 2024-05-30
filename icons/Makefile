#!/usr/bin/env make
# Requirements: Imagemagick

prefix ?= /usr

sizes = 16 24 32 48 64 72 96 128 256 512 1024
theme = hicolor
category = apps

icons = \
  $(foreach size,$(sizes),$(size)x$(size)/$(category)/expidus.png) \
  scalable/$(category)/expidus.svg \

install_dest = $(DESTDIR)$(prefix)/share/icons/$(theme)

all: $(icons)

%/$(category)/expidus.png: ../logo/expidus.svg
	@mkdir -p $(@D)
	convert -background none -resize $* $< $@

scalable/$(category)/expidus.svg: ../logo/expidus.svg
	@mkdir -p $(@D)
	cp $< $@

$(install_dest)/%: %
	install -D $< $@

install: $(foreach icon,$(icons),$(install_dest)/$(icon))

clean:
	rm -f $(icons)

.PHONY: all install clean
