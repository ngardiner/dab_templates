
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap
	dab install ansible
	install -m 0700 runonce.sh ${BASEDIR}/etc/init.d/firstboot
	install -m 0700 custom.sh ${BASEDIR}/tmp
	dab exec /bin/bash ${BASEDIR}/tmp/custom.sh
	dab exec rm -f ${BASEDIR}/tmp/custom.sh

finalize:
	dab finalize

info/init_ok: dab.conf
	dab init
	touch $@

.PHONY: template
template:
	cp ubuntu-16.04-ansible_16.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
