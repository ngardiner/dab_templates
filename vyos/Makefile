
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap

	# Dependancies
	dab install autoconf automake bison build-essential flex
	dab install libzip-dev libpci-dev

	# Clone git repos from vyos
	git clone https://github.com/vyos/vyatta-bash
	git clone https://github.com/vyos/vyatta-biosdevname
	git clone https://github.com/vyos/vyatta-busybox
	git clone https://github.com/vyos/vyatta-cfg

	# Place vyos sources inside image
	rsync -a vyatta-bash ${BASEDIR}/tmp/
	rsync -a vyatta-biosdevname ${BASEDIR}/tmp/
	rsync -a vyatta-busybox ${BASEDIR}/tmp/

	# Build Vyatta bash
	dab exec bash -c "cd /tmp/vyatta-bash && ./configure"
	dab exec bash -c "cd /tmp/vyatta-bash && make"
	dab exec bash -c "cd /tmp/vyatta-bash && make install"

	dab exec bash -c "cd /tmp/vyatta-biosdevname && aclocal"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && autoreconf --install"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && automake --add-missing"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && autoconf"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && ./configure"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && make"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && make install"

	dab exec bash -c "cd /tmp/vyatta-busybox && make"
	dab exec bash -c "cd /tmp/vyatta-busybox && make install"

	dab exec bash -c "cd /tmp/vyatta-cfg && aclocal"
	dab exec bash -c "cd /tmp/vyatta-cfg && autoreconf --install"
	dab exec bash -c "cd /tmp/vyatta-cfg && make"
	dab exec bash -c "cd /tmp/vyatta-cfg && make install"

	dab exec rm -rf /tmp/vyatta-bash
	dab exec rm -rf /tmp/vyatta-biosdevname
	dab exec rm -rf /tmp/vyatta-busybox
	dab exec rm -rf /tmp/vyatta-cfg

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
	cp ubuntu-16.04-vyos_16.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -f *~
	rm -rf vyatta-bash
	rm -rf vyatta-biosdevname
	rm -rf vyatta-busybox
	rm -rf vyatta-cfg

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
	rm -rf vyatta-bash
	rm -rf vyatta-biosdevname
	rm -rf vyatta-busybox
	rm -rf vyatta-cfg
