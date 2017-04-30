
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap

	# Dependancies
	dab install autoconf automake bison build-essential flex
	dab install gobject-introspection libpci-dev libtool libzip-dev
	dab install pkg-config

	# Clone git repos from vyos
	git clone https://github.com/vyos/vyatta-bash
	git clone https://github.com/vyos/vyatta-biosdevname
	git clone https://github.com/vyos/vyatta-busybox
	git clone https://github.com/vyos/vyatta-cfg

	# Place vyos sources inside image
	rsync -a vyatta-bash ${BASEDIR}/tmp/
	rsync -a vyatta-biosdevname ${BASEDIR}/tmp/
	rsync -a vyatta-busybox ${BASEDIR}/tmp/
	rsync -a vyatta-cfg ${BASEDIR}/tmp/

	# Build Vyatta bash
	dab exec bash -c "cd /tmp/vyatta-bash && ./configure > /tmp/vyatta-bash.configure.log"
	dab exec bash -c "cd /tmp/vyatta-bash && make > /tmp/vyatta-bash.make.log"
	dab exec bash -c "cd /tmp/vyatta-bash && make install > /tmp/vyatta-bash.makeinstall.log"

	dab exec bash -c "cd /tmp/vyatta-biosdevname && aclocal > /tmp/vyatta-biosdevname.aclocal.log"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && autoreconf --install > /tmp/vyatta-biosdevname.autoreconf.log"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && automake --add-missing > /tmp/vyatta-biosdevname.automake.log"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && autoconf > /tmp/vyatta-biosdevname.autoconf.log"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && ./configure > /tmp/vyatta-biosdevname.configure.log"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && make > /tmp/vyatta-biosdevname.make.log"
	dab exec bash -c "cd /tmp/vyatta-biosdevname && make install > /tmp/vyatta-biosdevname.makeinstall.log"

	dab exec bash -c "cd /tmp/vyatta-busybox && make defconfig > /tmp/vyatta-busybox.makedefconfig.log"
	-dab exec bash -c "cd /tmp/vyatta-busybox && make install > /tmp/vyatta-busybox.makeinstall.log"

	dab exec bash -c "cd /tmp/vyatta-cfg && aclocal > /tmp/vyatta-cfg.aclocal.log"
	dab exec bash -c "cd /tmp/vyatta-cfg && autoreconf --install > /tmp/vyatta-cfg.autoreconf.log"
	dab exec bash -c "cd /tmp/vyatta-cfg && automake --add-missing > /tmp/vyatta-cfg.automake.log"
	dab exec bash -c "cd /tmp/vyatta-cfg && autoconf > /tmp/vyatta-cfg.autoconf.log"
	dab exec bash -c "cd /tmp/vyatta-cfg && ./configure > /tmp/vyatta-cfg.configure.log"
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
