
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

all: info/init_ok
	dab bootstrap
	dab install ansible
	dab finalize

info/init_ok: dab.conf
	dab init
	touch $@

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
