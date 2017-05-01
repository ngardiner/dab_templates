
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap

	# These are known packaged dependancies
	dab install autoconf automake libtool make gawk libreadline-dev
	dab install texinfo dejagnu pkg-config libpam0g-dev libjson-c-dev bison
	dab install python-pytest libc-ares-dev python3-dev flex

	# Clone repository
	git clone https://github.com/frrouting/frr.git rootfs/usr/src/frr

	# See custom.sh for build and configuration scripts for frr

	install -m 0700 runonce.sh ${BASEDIR}/etc/init.d/firstboot
	dab exec update-rc.d firstboot defaults
	install -m 0700 custom.sh ${BASEDIR}/tmp
	dab exec /bin/bash /tmp/custom.sh
	dab exec rm -f /tmp/custom.sh

finalize:
	dab finalize

info/init_ok: dab.conf
	dab init
	touch $@

.PHONY: template
template:
	cp ubuntu-16.04-frr_16.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
