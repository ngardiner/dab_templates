
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
CT=conntrack-tools
DE=dab exec bash -c
GC=git clone https://github.com/vyos/
IP=igmpproxy
IR=iproute
IS=ipset
PT=iptables
OV=vyatta-openvpn
QU=vyatta-quagga
VN=vyos-nhrp
VO=vyos-opennhrp
VU=vyatta-util
VV=vyatta-vrrp
VZ=vyatta-zone

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap

	# Dependancies for build
	dab install autoconf automake bison build-essential flex gawk
	dab install gobject-introspection libpci-dev libtool libzip-dev
	dab install libapt-pkg-dev libglib2.0-dev pkg-config texinfo
	dab install libboost-filesystem-dev libglib2.0-dev libc-ares-dev

	# Clone git repos from vyos
	$(GC)$(BA) -b $(RELEASE)
	$(GC)$(BB) -b $(RELEASE)
	$(GC)$(BD) -b $(RELEASE)
	$(GC)$(CF) -b $(RELEASE)
	$(GC)$(CQ) -b $(RELEASE)
	$(GC)$(CT) -b $(RELEASE)
	$(GC)$(IP) -b $(RELEASE)
	$(GC)$(IR) -b $(RELEASE)
	$(GC)$(IS) -b $(RELEASE)
	$(GC)$(OV) -b $(RELEASE)
	$(GC)$(PT) -b $(RELEASE)
	$(GC)$(QU) -b $(RELEASE)
	$(GC)$(VN) -b $(RELEASE)
	$(GC)$(VO) -b $(RELEASE)
	$(GC)$(VU) -b $(RELEASE)
	$(GC)$(VV) -b $(RELEASE)
	$(GC)$(VZ) -b $(RELEASE)

	# Place vyos sources inside image
	rsync -a $(BA) ${BASEDIR}/tmp/
	rsync -a $(BB) ${BASEDIR}/tmp/
	rsync -a $(BD) ${BASEDIR}/tmp/
	rsync -a $(CF) ${BASEDIR}/tmp/
	rsync -a $(CQ) ${BASEDIR}/tmp/
	rsync -a $(CT) ${BASEDIR}/tmp/
	rsync -a $(IP) ${BASEDIR}/tmp/
	rsync -a $(IR) ${BASEDIR}/tmp/
	rsync -a $(IS) ${BASEDIR}/tmp/
	rsync -a $(OV) ${BASEDIR}/tmp/
	rsync -a $(PT) ${BASEDIR}/tmp/
	rsync -a $(QU) ${BASEDIR}/tmp/
	rsync -a $(VN) ${BASEDIR}/tmp/
	rsync -a $(VO) ${BASEDIR}/tmp/
	rsync -a $(VU) ${BASEDIR}/tmp/
	rsync -a $(VV) ${BASEDIR}/tmp/
	rsync -a $(VZ) ${BASEDIR}/tmp/

	# Build Vyatta bash
	$(DE) "$(CD)$(BA) && ./configure > /tmp/$(BA).configure.log"
	$(DE) "$(CD)$(BA) && make > /tmp/$(BA).make.log 2>&1"
	$(DE) "$(CD)$(BA) && make install > /tmp/$(BA).makeinstall.log"

	$(DE) "$(CD)$(BD) && aclocal > /tmp/$(BD).aclocal.log 2>&1"
	$(DE) "$(CD)$(BD) && autoreconf --install > /tmp/$(BD).autoreconf.log"
	$(DE) "$(CD)$(BD) && automake --add-missing > /tmp/$(BD).automake.log"
	$(DE) "$(CD)$(BD) && autoconf > /tmp/$(BD).autoconf.log 2>&1"
	$(DE) "$(CD)$(BD) && ./configure > /tmp/$(BD).configure.log 2>&1"
	$(DE) "$(CD)$(BD) && make > /tmp/$(BD).make.log 2>&1"
	$(DE) "$(CD)$(BD) && make install > /tmp/$(BD).makeinstall.log 2>&1"

	$(DE) "$(CD)$(BB) && make defconfig > /tmp/$(BB).makedefconfig.log 2>&1"
	-$(DE) "$(CD)$(BB) && make install > /tmp/$(BB).makeinstall.log 2>&1"

	$(DE) "$(CD)$(CF) && aclocal > /tmp/$(CF).aclocal.log 2>&1"
	$(DE) "$(CD)$(CF) && autoreconf --install > /tmp/$(CF).autoreconf.log"
	$(DE) "$(CD)$(CF) && automake --add-missing > /tmp/$(CF).automake.log"
	$(DE) "$(CD)$(CF) && autoconf > /tmp/$(CF).autoconf.log 2>&1"
	$(DE) "$(CD)$(CF) && ./configure > /tmp/$(CF).configure.log 2>&1"
	-$(DE) "$(CD)$(CF) && make > /tmp/$(CF).make.log 2>&1"
	-$(DE) "$(CD)$(CF) && make install > /tmp/$(CF).makeinstall.log 2>&1"

	$(DE) "$(CD)$(CQ) && aclocal > /tmp/$(CQ).aclocal.log 2>&1"
	$(DE) "$(CD)$(CQ) && autoreconf --install > /tmp/$(CQ).autoreconf.log"
	$(DE) "$(CD)$(CQ) && automake --add-missing > /tmp/$(CQ).automake.log"
	$(DE) "$(CD)$(CQ) && autoconf > /tmp/$(CQ).autoconf.log 2>&1"
	$(DE) "$(CD)$(CQ) && ./configure > /tmp/$(CQ).configure.log 2>&1"
	$(DE) "$(CD)$(CQ) && make > /tmp/$(CQ).make.log 2>&1"
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
	$(DE) "$(CD)$(VO) && make install > /tmp/$(VO).makeinstall.log"

	$(DE) "$(CD)$(VU) && aclocal > /tmp/$(VU).aclocal.log"
	$(DE) "$(CD)$(VU) && autoreconf --install > /tmp/$(VU).autoreconf.log"
	$(DE) "$(CD)$(VU) && automake --add-missing > /tmp/$(VU).automake.log"
	$(DE) "$(CD)$(VU) && autoconf > /tmp/$(VU).autoconf.log"
	$(DE) "$(CD)$(VU) && ./configure > /tmp/$(VU).configure.log"
	$(DE) "$(CD)$(VU) && make > /tmp/$(VU).make.log"
	$(DE) "$(CD)$(VU) && make install > /tmp/$(VU).makeinstall.log"

	$(DE) "$(CD)$(VV) && aclocal > /tmp/$(VV).aclocal.log"
	$(DE) "$(CD)$(VV) && autoreconf --install > /tmp/$(VV).autoreconf.log"
	$(DE) "$(CD)$(VV) && automake --add-missing > /tmp/$(VV).automake.log"
	$(DE) "$(CD)$(VV) && autoconf > /tmp/$(VV).autoconf.log"
	$(DE) "$(CD)$(VV) && ./configure > /tmp/$(VV).configure.log"
	$(DE) "$(CD)$(VV) && make > /tmp/$(VV).make.log"
	$(DE) "$(CD)$(VV) && make install > /tmp/$(VV).makeinstall.log"

	$(DE) "$(CD)$(OV) && aclocal > /tmp/$(OV).aclocal.log"
	$(DE) "$(CD)$(OV) && autoreconf --install > /tmp/$(OV).autoreconf.log"
	$(DE) "$(CD)$(OV) && automake --add-missing > /tmp/$(OV).automake.log"
	$(DE) "$(CD)$(OV) && autoconf > /tmp/$(OV).autoconf.log"
	$(DE) "$(CD)$(OV) && ./configure > /tmp/$(OV).configure.log"
	$(DE) "$(CD)$(OV) && make > /tmp/$(OV).make.log"
	$(DE) "$(CD)$(OV) && make install > /tmp/$(OV).makeinstall.log"

	$(DE) "$(CD)$(QU) && aclocal > /tmp/$(QU).aclocal.log"
	$(DE) "$(CD)$(QU) && autoreconf --install > /tmp/$(QU).autoreconf.log"
	$(DE) "$(CD)$(QU) && automake --add-missing > /tmp/$(QU).automake.log"
	$(DE) "$(CD)$(QU) && autoconf > /tmp/$(QU).autoconf.log"
	$(DE) "$(CD)$(QU) && ./configure > /tmp/$(QU).configure.log"
	$(DE) "$(CD)$(QU) && make > /tmp/$(QU).make.log"
	$(DE) "$(CD)$(QU) && make install > /tmp/$(QU).makeinstall.log"

	$(DE) "$(CD)$(CT) && make > /tmp/$(CT).make.log"
	$(DE) "$(CD)$(CT) && make install > /tmp/$(CT).makeinstall.log"

	$(DE) "$(CD)$(IP) && make > /tmp/$(IP).make.log"
	$(DE) "$(CD)$(IP) && make install > /tmp/$(IP).makeinstall.log"

	$(DE) "$(CD)$(IR) && make > /tmp/$(IR).make.log"
	$(DE) "$(CD)$(IR) && make install > /tmp/$(IR).makeinstall.log"

	$(DE) "$(CD)$(IS) && make > /tmp/$(IS).make.log"
	$(DE) "$(CD)$(IS) && make install > /tmp/$(IS).makeinstall.log"

	$(DE) "$(CD)$(PT) && make > /tmp/$(PT).make.log"
	$(DE) "$(CD)$(PT) && make install > /tmp/$(PT).makeinstall.log"

	# Remove build dependencies
	dab exec dpkg -r autoconf automake flex gawk libpci-dev libzip-dev
	dab exec dpkg -r bison libapt-pkg-dev libglib2.0-dev texinfo
	dab exec dpkg -r libboost-filesystem-dev libglib2.0-dev libc-ares-dev
	dab exec dpkg -r build-essential gobject-introspection
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
	dab exec rm -rf /tmp/$(VU)
	dab exec rm -rf /tmp/$(VV)
	dab exec rm -rf /tmp/$(OV)
	dab exec rm -rf /tmp/$(QU)

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
	rm -rf $(VU)
	rm -rf $(VV)
	rm -rf $(OV)
	rm -rf $(QU)

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
	rm -rf $(VU)
	rm -rf $(VV)
	rm -rf $(OV)
	rm -rf $(QU)
