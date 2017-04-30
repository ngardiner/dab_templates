
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

# Release branch of vyos to use.
RELEASE=helium

# Our great compresson scheme
BA=vyatta-bash
BB=vyatta-busybox
BD=vyatta-biosdevname
CD=cd /tmp/
CF=vyatta-cfg
CQ=vyatta-cfg-quagga
DE=dab exec bash -c
GC=git clone https://github.com/vyos/
VN=vyos-nhrp
VO=vyos-opennhrp
VZ=vyatta-zone

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap

	# Dependancies for build
	dab install autoconf automake bison build-essential flex
	dab install gobject-introspection libpci-dev libtool libzip-dev
	dab install libapt-pkg-dev libglib2.0-dev pkg-config
	dab install libboost-filesystem-dev libglib2.0-dev

	# Clone git repos from vyos
	$(GC)$(BA) -b $(RELEASE)
	$(GC)$(BD) -b $(RELEASE)
	$(GC)$(BB) -b $(RELEASE)
	$(GC)$(CF) -b $(RELEASE)
	$(GC)$(CQ) -b $(RELEASE)
	$(GC)$(VZ) -b $(RELEASE)
	$(GC)$(VN) -b $(RELEASE)
	$(GC)$(VO) -b $(RELEASE)

	# Place vyos sources inside image
	rsync -a $(BA) ${BASEDIR}/tmp/
	rsync -a $(BD) ${BASEDIR}/tmp/
	rsync -a $(BB) ${BASEDIR}/tmp/
	rsync -a $(CF) ${BASEDIR}/tmp/
	rsync -a $(CQ) ${BASEDIR}/tmp/
	rsync -a $(VZ) ${BASEDIR}/tmp/
	rsync -a $(VN) ${BASEDIR}/tmp/
	rsync -a $(VO) ${BASEDIR}/tmp/

	# Build Vyatta bash
	$(DE) "$(CD)$(BA) && ./configure > /tmp/$(BA).configure.log"
	$(DE) "$(CD)$(BA) && make > /tmp/$(BA).make.log 2>&1"
	$(DE) "$(CD)$(BA) && make install > /tmp/$(BA).makeinstall.log"

	$(DE) "$(CD)$(BD) && aclocal > /tmp/$(BD).aclocal.log"
	$(DE) "$(CD)$(BD) && autoreconf --install > /tmp/$(BD).autoreconf.log"
	$(DE) "$(CD)$(BD) && automake --add-missing > /tmp/$(BD).automake.log"
	$(DE) "$(CD)$(BD) && autoconf > /tmp/$(BD).autoconf.log"
	$(DE) "$(CD)$(BD) && ./configure > /tmp/$(BD).configure.log"
	$(DE) "$(CD)$(BD) && make > /tmp/$(BD).make.log 2>&1"
	$(DE) "$(CD)$(BD) && make install > /tmp/$(BD).makeinstall.log"

	$(DE) "$(CD)$(BB) && make defconfig > /tmp/$(BB).makedefconfig.log 2>&1"
	-$(DE) "$(CD)$(BB) && make install > /tmp/$(BB).makeinstall.log 2>&1"

	$(DE) "$(CD)$(CF) && aclocal > /tmp/$(CF).aclocal.log"
	$(DE) "$(CD)$(CF) && autoreconf --install > /tmp/$(CF).autoreconf.log"
	$(DE) "$(CD)$(CF) && automake --add-missing > /tmp/$(CF).automake.log"
	$(DE) "$(CD)$(CF) && autoconf > /tmp/$(CF).autoconf.log"
	$(DE) "$(CD)$(CF) && ./configure > /tmp/$(CF).configure.log"
	-$(DE) "$(CD)$(CF) && make > /tmp/$(CF).make.log 2>&1"
	-$(DE) "$(CD)$(CF) && make install > /tmp/$(CF).makeinstall.log 2>&1"

	$(DE) "$(CD)$(CQ) && aclocal > /tmp/$(CQ).aclocal.log"
	$(DE) "$(CD)$(CQ) && autoreconf --install > /tmp/$(CQ).autoreconf.log"
	$(DE) "$(CD)$(CQ) && automake --add-missing > /tmp/$(CQ).automake.log"
	$(DE) "$(CD)$(CQ) && autoconf > /tmp/$(CQ).autoconf.log"
	$(DE) "$(CD)$(CQ) && ./configure > /tmp/$(CQ).configure.log"
	$(DE) "$(CD)$(CQ) && make > /tmp/$(CQ).make.log"
	$(DE) "$(CD)$(CQ) && make install > /tmp/$(CQ).makeinstall.log"

	$(DE) "$(CD)$(VZ) && aclocal > /tmp/$(VZ).aclocal.log"
	$(DE) "$(CD)$(VZ) && autoreconf --install > /tmp/$(VZ).autoreconf.log"
	$(DE) "$(CD)$(VZ) && automake --add-missing > /tmp/$(VZ).automake.log"
	$(DE) "$(CD)$(VZ) && autoconf > /tmp/$(VZ).autoconf.log"
	$(DE) "$(CD)$(VZ) && ./configure > /tmp/$(VZ).configure.log"
	$(DE) "$(CD)$(VZ) && make > /tmp/$(VZ).make.log"
	$(DE) "$(CD)$(VZ) && make install > /tmp/$(VZ).makeinstall.log"

	$(DE) "$(CD)$(VN) && aclocal > /tmp/$(VN).aclocal.log"
	$(DE) "$(CD)$(VN) && autoreconf --install > /tmp/$(VN).autoreconf.log"
	$(DE) "$(CD)$(VN) && automake --add-missing > /tmp/$(VN).automake.log"
	$(DE) "$(CD)$(VN) && autoconf > /tmp/$(VN).autoconf.log"
	$(DE) "$(CD)$(VN) && ./configure > /tmp/$(VN).configure.log"
	$(DE) "$(CD)$(VN) && make > /tmp/$(VN).make.log"
	$(DE) "$(CD)$(VN) && make install > /tmp/$(VN).makeinstall.log"

	$(DE) "$(CD)$(VO) && make > /tmp/$(VO).make.log"

	# Remove build dependencies
	dab exec dpkg -r autoconf automake
	dab exec dpkg -r bison flex
	dab exec apt-get clean

	# Remove source trees
	dab exec rm -rf /tmp/$(BA)
	dab exec rm -rf /tmp/$(BD)
	dab exec rm -rf /tmp/$(BB)
	dab exec rm -rf /tmp/$(CF)
	dab exec rm -rf /tmp/$(CQ)
	dab exec rm -rf /tmp/$(VZ)
	dab exec rm -rf /tmp/$(VN)
	dab exec rm -rf /tmp/$(VO)

	# Perform final configuration
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
	rm -rf $(BA)
	rm -rf $(BD)
	rm -rf $(BB)
	rm -rf $(CF)
	rm -rf $(CQ)
	rm -rf $(VZ)
	rm -rf $(VN)
	rm -rf $(VO)

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
	rm -rf $(BA)
	rm -rf $(BD)
	rm -rf $(BB)
	rm -rf $(CF)
	rm -rf $(CQ)
	rm -rf $(VZ)
	rm -rf $(VN)
	rm -rf $(VO)
