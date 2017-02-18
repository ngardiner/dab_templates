
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global
all: info/init_ok bootstrap global

bootstrap:
	dab bootstrap
	dab install letsencrypt nginx
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
