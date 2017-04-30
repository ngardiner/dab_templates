
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

# Release branch of vyos to use.
RELEASE=helium

# Our great compresson scheme
AM=automake --add-missing
AR=autoreconf --install
BA=vyatta-bash
BB=vyatta-busybox
BD=vyatta-biosdevname
CD=cd /tmp/
CF=vyatta-cfg
CQ=vyatta-cfg-quagga
CT=conntrack-tools
CZ=libmnl
DE=dab exec bash -c
GC=git clone https://github.com/vyos/
IP=igmpproxy
IR=vyatta-iproute
IS=ipset
PA=pmacct
PC=libcap
PP=ppp
PT=iptables
OV=vyatta-openvpn
QU=vyatta-quagga
VN=vyos-nhrp
VO=vyos-opennhrp
VU=vyatta-util
VV=vyatta-vrrp
VZ=vyatta-zone
WG=vyatta-webgui
WP=vyatta-webproxy

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap

	# Dependancies for build
	dab install autoconf automake bison build-essential flex gawk
	dab install gobject-introspection libpci-dev libtool libzip-dev
	dab install libapt-pkg-dev libglib2.0-dev pkg-config texinfo
	dab install libnfnetlink-dev libmnl-dev libnetfilter-conntrack-dev
	dab install libnetfilter-cttimeout-dev libnetfilter-cthelper0-dev
	dab install libboost-filesystem-dev libglib2.0-dev libc-ares-dev
	dab install libnetfilter-queue-dev libdb-dev

	# Clone git repos from vyos
	$(GC)$(BA) -b $(RELEASE)
	$(GC)$(BB) -b $(RELEASE)
	$(GC)$(BD) -b $(RELEASE)
	$(GC)$(CF) -b $(RELEASE)
	$(GC)$(CQ) -b $(RELEASE)
	$(GC)$(CT) -b $(RELEASE)
	$(GC)$(CZ) -b $(RELEASE)
	$(GC)$(IP) -b $(RELEASE)
	$(GC)$(IR) -b $(RELEASE)
	$(GC)$(IS) -b $(RELEASE)
	$(GC)$(OV) -b $(RELEASE)
	$(GC)$(PA) -b $(RELEASE)
	$(GC)$(PC) -b $(RELEASE)
	$(GC)$(PP) -b $(RELEASE)
	$(GC)$(PT) -b $(RELEASE)
	$(GC)$(QU) -b $(RELEASE)
	$(GC)$(VN) -b $(RELEASE)
	$(GC)$(VO) -b $(RELEASE)
	$(GC)$(VU) -b $(RELEASE)
	$(GC)$(VV) -b $(RELEASE)
	$(GC)$(VZ) -b $(RELEASE)
	$(GC)$(WG) -b $(RELEASE)
	$(GC)$(WP) -b $(RELEASE)

	# Place vyos sources inside image
	rsync -a $(BA) ${BASEDIR}/tmp/
	rsync -a $(BB) ${BASEDIR}/tmp/
	rsync -a $(BD) ${BASEDIR}/tmp/
	rsync -a $(CF) ${BASEDIR}/tmp/
	rsync -a $(CQ) ${BASEDIR}/tmp/
	rsync -a $(CT) ${BASEDIR}/tmp/
	rsync -a $(CZ) ${BASEDIR}/tmp/
	rsync -a $(IP) ${BASEDIR}/tmp/
	rsync -a $(IR) ${BASEDIR}/tmp/
	rsync -a $(IS) ${BASEDIR}/tmp/
	rsync -a $(OV) ${BASEDIR}/tmp/
	rsync -a $(PA) ${BASEDIR}/tmp/
	rsync -a $(PC) ${BASEDIR}/tmp/
	rsync -a $(PP) ${BASEDIR}/tmp/
	rsync -a $(PT) ${BASEDIR}/tmp/
	rsync -a $(QU) ${BASEDIR}/tmp/
	rsync -a $(VN) ${BASEDIR}/tmp/
	rsync -a $(VO) ${BASEDIR}/tmp/
	rsync -a $(VU) ${BASEDIR}/tmp/
	rsync -a $(VV) ${BASEDIR}/tmp/
	rsync -a $(VZ) ${BASEDIR}/tmp/
	rsync -a $(WG) ${BASEDIR}/tmp/
	rsync -a $(WP) ${BASEDIR}/tmp/

	# Apply patches prior to compile
	cat patch/* | patch -p0

	# Build Vyatta bash
	$(DE) "$(CD)$(BA) && ./configure > /tmp/$(BA).configure.log 2>&1"
	$(DE) "$(CD)$(BA) && make > /tmp/$(BA).make.log 2>&1"
	$(DE) "$(CD)$(BA) && make install > /tmp/$(BA).makeinstall.log 2>&1"

	$(DE) "$(CD)$(BD) && aclocal > /tmp/$(BD).aclocal.log 2>&1"
	$(DE) "$(CD)$(BD) && $(AR) > /tmp/$(BD).autoreconf.log 2>&1"
	$(DE) "$(CD)$(BD) && $(AM) > /tmp/$(BD).automake.log 2>&1"
	$(DE) "$(CD)$(BD) && autoconf > /tmp/$(BD).autoconf.log 2>&1"
	$(DE) "$(CD)$(BD) && ./configure > /tmp/$(BD).configure.log 2>&1"
	$(DE) "$(CD)$(BD) && make > /tmp/$(BD).make.log 2>&1"
	$(DE) "$(CD)$(BD) && make install > /tmp/$(BD).makeinstall.log 2>&1"

	$(DE) "$(CD)$(BB) && make defconfig > /tmp/$(BB).makedefconfig.log 2>&1"
	-$(DE) "$(CD)$(BB) && make install > /tmp/$(BB).makeinstall.log 2>&1"

	# vyatta-cfg compile
	$(DE) "$(CD)$(CF) && aclocal > /tmp/$(CF).aclocal.log 2>&1"
	$(DE) "$(CD)$(CF) && $(AR) > /tmp/$(CF).autoreconf.log 2>&1"
	$(DE) "$(CD)$(CF) && $(AM) > /tmp/$(CF).automake.log 2>&1"
	$(DE) "$(CD)$(CF) && autoconf > /tmp/$(CF).autoconf.log 2>&1"
	$(DE) "$(CD)$(CF) && ./configure > /tmp/$(CF).configure.log 2>&1"
	cp rootfs/usr/lib/x86_64-linux-gnu/glib-2.0/include/glibconfig.h rootfs/usr/include/glibconfig.h
	-$(DE) "$(CD)$(CF) && make > /tmp/$(CF).make.log 2>&1"
	-$(DE) "$(CD)$(CF) && make install > /tmp/$(CF).makeinstall.log 2>&1"

	$(DE) "$(CD)$(CQ) && aclocal > /tmp/$(CQ).aclocal.log 2>&1"
	$(DE) "$(CD)$(CQ) && $(AR) > /tmp/$(CQ).autoreconf.log 2>&1"
	$(DE) "$(CD)$(CQ) && $(AM) > /tmp/$(CQ).automake.log 2>&1"
	$(DE) "$(CD)$(CQ) && autoconf > /tmp/$(CQ).autoconf.log 2>&1"
	$(DE) "$(CD)$(CQ) && ./configure > /tmp/$(CQ).configure.log 2>&1"
	$(DE) "$(CD)$(CQ) && make > /tmp/$(CQ).make.log 2>&1"
	$(DE) "$(CD)$(CQ) && make install > /tmp/$(CQ).makeinstall.log 2>&1"

	$(DE) "$(CD)$(VZ) && aclocal > /tmp/$(VZ).aclocal.log 2>&1"
	$(DE) "$(CD)$(VZ) && $(AR) > /tmp/$(VZ).autoreconf.log 2>&1"
	$(DE) "$(CD)$(VZ) && $(AM) > /tmp/$(VZ).automake.log 2>&1"
	$(DE) "$(CD)$(VZ) && autoconf > /tmp/$(VZ).autoconf.log 2>&1"
	$(DE) "$(CD)$(VZ) && ./configure > /tmp/$(VZ).configure.log 2>&1"
	$(DE) "$(CD)$(VZ) && make > /tmp/$(VZ).make.log 2>&1"
	$(DE) "$(CD)$(VZ) && make install > /tmp/$(VZ).makeinstall.log 2>&1"

	$(DE) "$(CD)$(VN) && aclocal > /tmp/$(VN).aclocal.log 2>&1"
	$(DE) "$(CD)$(VN) && $(AR) > /tmp/$(VN).autoreconf.log 2>&1"
	$(DE) "$(CD)$(VN) && $(AM) > /tmp/$(VN).automake.log 2>&1"
	$(DE) "$(CD)$(VN) && autoconf > /tmp/$(VN).autoconf.log 2>&1"
	$(DE) "$(CD)$(VN) && ./configure > /tmp/$(VN).configure.log 2>&1"
	$(DE) "$(CD)$(VN) && make > /tmp/$(VN).make.log 2>&1"
	$(DE) "$(CD)$(VN) && make install > /tmp/$(VN).makeinstall.log 2>&1"

	$(DE) "$(CD)$(VO) && make > /tmp/$(VO).make.log 2>&1"
	$(DE) "$(CD)$(VO) && make install > /tmp/$(VO).makeinstall.log 2>&1"

	$(DE) "$(CD)$(VU) && aclocal > /tmp/$(VU).aclocal.log 2>&1"
	$(DE) "$(CD)$(VU) && $(AR) > /tmp/$(VU).autoreconf.log 2>&1"
	$(DE) "$(CD)$(VU) && $(AM) > /tmp/$(VU).automake.log 2>&1"
	$(DE) "$(CD)$(VU) && autoconf > /tmp/$(VU).autoconf.log 2>&1"
	$(DE) "$(CD)$(VU) && ./configure > /tmp/$(VU).configure.log 2>&1"
	$(DE) "$(CD)$(VU) && make > /tmp/$(VU).make.log 2>&1"
	$(DE) "$(CD)$(VU) && make install > /tmp/$(VU).makeinstall.log 2>&1"

	$(DE) "$(CD)$(VV) && aclocal > /tmp/$(VV).aclocal.log 2>&1"
	$(DE) "$(CD)$(VV) && $(AR) > /tmp/$(VV).autoreconf.log 2>&1"
	$(DE) "$(CD)$(VV) && $(AM) > /tmp/$(VV).automake.log 2>&1"
	$(DE) "$(CD)$(VV) && autoconf > /tmp/$(VV).autoconf.log 2>&1"
	$(DE) "$(CD)$(VV) && ./configure > /tmp/$(VV).configure.log 2>&1"
	$(DE) "$(CD)$(VV) && make > /tmp/$(VV).make.log 2>&1"
	$(DE) "$(CD)$(VV) && make install > /tmp/$(VV).makeinstall.log 2>&1"

	$(DE) "$(CD)$(OV) && aclocal > /tmp/$(OV).aclocal.log 2>&1"
	$(DE) "$(CD)$(OV) && $(AR) > /tmp/$(OV).autoreconf.log 2>&1"
	$(DE) "$(CD)$(OV) && $(AM) > /tmp/$(OV).automake.log 2>&1"
	$(DE) "$(CD)$(OV) && autoconf > /tmp/$(OV).autoconf.log 2>&1"
	$(DE) "$(CD)$(OV) && ./configure > /tmp/$(OV).configure.log 2>&1"
	$(DE) "$(CD)$(OV) && make > /tmp/$(OV).make.log 2>&1"
	$(DE) "$(CD)$(OV) && make install > /tmp/$(OV).makeinstall.log 2>&1"

	$(DE) "$(CD)$(QU) && aclocal > /tmp/$(QU).aclocal.log 2>&1"
	$(DE) "$(CD)$(QU) && $(AR) > /tmp/$(QU).autoreconf.log 2>&1"
	$(DE) "$(CD)$(QU) && $(AM) > /tmp/$(QU).automake.log 2>&1"
	$(DE) "$(CD)$(QU) && autoconf > /tmp/$(QU).autoconf.log 2>&1"
	$(DE) "$(CD)$(QU) && ./configure > /tmp/$(QU).configure.log 2>&1"
	$(DE) "$(CD)$(QU) && make > /tmp/$(QU).make.log 2>&1"
	$(DE) "$(CD)$(QU) && make install > /tmp/$(QU).makeinstall.log 2>&1"

	$(DE) "$(CD)$(CT) && aclocal > /tmp/$(CT).aclocal.log 2>&1"
	$(DE) "$(CD)$(CT) && $(AR) > /tmp/$(CT).autoreconf.log 2>&1"
	$(DE) "$(CD)$(CT) && $(AM) > /tmp/$(CT).automake.log 2>&1"
	$(DE) "$(CD)$(CT) && autoconf > /tmp/$(CT).autoconf.log 2>&1"
	$(DE) "$(CD)$(CT) && ./configure > /tmp/$(CT).configure.log 2>&1"
	$(DE) "$(CD)$(CT) && make > /tmp/$(CT).make.log 2>&1"
	$(DE) "$(CD)$(CT) && make install > /tmp/$(CT).makeinstall.log 2>&1"

	$(DE) "$(CD)$(IP) && aclocal > /tmp/$(IP).aclocal.log 2>&1"
	$(DE) "$(CD)$(IP) && $(AR) > /tmp/$(IP).autoreconf.log 2>&1"
	$(DE) "$(CD)$(IP) && $(AM) > /tmp/$(IP).automake.log 2>&1"
	$(DE) "$(CD)$(IP) && autoconf > /tmp/$(IP).autoconf.log 2>&1"
	$(DE) "$(CD)$(IP) && ./configure > /tmp/$(IP).configure.log 2>&1"
	$(DE) "$(CD)$(IP) && make > /tmp/$(IP).make.log 2>&1"
	$(DE) "$(CD)$(IP) && make install > /tmp/$(IP).makeinstall.log 2>&1"

	$(DE) "$(CD)$(IR) && ./configure > /tmp/$(IR).configure.log 2>&1"
	$(DE) "$(CD)$(IR) && make > /tmp/$(IR).make.log 2>&1"
	$(DE) "$(CD)$(IR) && make install > /tmp/$(IR).makeinstall.log 2>&1"

	$(DE) "$(CD)$(IS) && aclocal > /tmp/$(IS).aclocal.log 2>&1"
	$(DE) "$(CD)$(IS) && $(AR) > /tmp/$(IS).autoreconf.log 2>&1"
	$(DE) "$(CD)$(IS) && $(AM) > /tmp/$(IS).automake.log 2>&1"
	$(DE) "$(CD)$(IS) && autoconf > /tmp/$(IS).autoconf.log 2>&1"
	$(DE) "$(CD)$(IS) && ./configure > /tmp/$(IS).configure.log 2>&1"
	$(DE) "$(CD)$(IS) && make > /tmp/$(IS).make.log 2>&1"
	$(DE) "$(CD)$(IS) && make install > /tmp/$(IS).makeinstall.log 2>&1"

	$(DE) "$(CD)$(PT) && aclocal > /tmp/$(PT).aclocal.log 2>&1"
	$(DE) "$(CD)$(PT) && $(AR) > /tmp/$(PT).autoreconf.log 2>&1"
	$(DE) "$(CD)$(PT) && $(AM) > /tmp/$(PT).automake.log 2>&1"
	$(DE) "$(CD)$(PT) && autoconf > /tmp/$(PT).autoconf.log 2>&1"
	$(DE) "$(CD)$(PT) && ./configure > /tmp/$(PT).configure.log 2>&1"
	$(DE) "$(CD)$(PT) && make > /tmp/$(PT).make.log 2>&1"
	$(DE) "$(CD)$(PT) && make install > /tmp/$(PT).makeinstall.log 2>&1"

	$(DE) "$(CD)$(CZ) && make > /tmp/$(CZ).make.log 2>&1"
	$(DE) "$(CD)$(CZ) && make install > /tmp/$(CZ).makeinstall.log 2>&1"

	$(DE) "$(CD)$(PC) && make > /tmp/$(PC).make.log 2>&1"
	$(DE) "$(CD)$(PC) && make install > /tmp/$(PC).makeinstall.log 2>&1"

	$(DE) "$(CD)$(PP) && make > /tmp/$(PP).make.log 2>&1"
	$(DE) "$(CD)$(PP) && make install > /tmp/$(PP).makeinstall.log 2>&1"

	$(DE) "$(CD)$(WG) && make > /tmp/$(WG).make.log 2>&1"
	$(DE) "$(CD)$(WG) && make install > /tmp/$(WG).makeinstall.log 2>&1"

	$(DE) "$(CD)$(WP) && make > /tmp/$(WP).make.log 2>&1"
	$(DE) "$(CD)$(WP) && make install > /tmp/$(WP).makeinstall.log 2>&1"

	# Remove build dependencies
	dab exec dpkg -r autoconf automake flex gawk libpci-dev libzip-dev
	dab exec dpkg -r bison libapt-pkg-dev libglib2.0-dev texinfo
	dab exec dpkg -r libboost-filesystem-dev libglib2.0-dev libc-ares-dev
	dab exec dpkg -r libnfnetlink-dev libmnl-dev libnetfilter-conntrack-dev
	dab exec dpkg -r libnetfilter-cttimeout-dev libnetfilter-cthelper0-dev
	dab exec dpkg -r libnetfilter-queue-dev libdb-dev
	dab exec dpkg -r build-essential gobject-introspection
	dab exec apt-get clean

	# Remove source trees
	dab exec rm -rf /tmp/$(BA)
	dab exec rm -rf /tmp/$(BD)
	dab exec rm -rf /tmp/$(BB)
	dab exec rm -rf /tmp/$(CF)
	dab exec rm -rf /tmp/$(CQ)
	dab exec rm -rf /tmp/$(CZ)
	dab exec rm -rf /tmp/$(OV)
	dab exec rm -rf /tmp/$(QU)
	dab exec rm -rf /tmp/$(VN)
	dab exec rm -rf /tmp/$(VO)
	dab exec rm -rf /tmp/$(VU)
	dab exec rm -rf /tmp/$(VV)
	dab exec rm -rf /tmp/$(VZ)
	dab exec rm -rf /tmp/$(WG)
	dab exec rm -rf /tmp/$(WP)

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
	rm -rf $(BB)
	rm -rf $(BD)
	rm -rf $(CF)
	rm -rf $(CQ)
	rm -rf $(CT)
	rm -rf $(CZ)
	rm -rf $(IP)
	rm -rf $(IR)
	rm -rf $(IS)
	rm -rf $(OV)
	rm -rf $(PA)
	rm -rf $(PC)
	rm -rf $(PP)
	rm -rf $(PT)
	rm -rf $(QU)
	rm -rf $(VZ)
	rm -rf $(VN)
	rm -rf $(VO)
	rm -rf $(VU)
	rm -rf $(VV)
	rm -rf $(WG)
	rm -rf $(WP)

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
	rm -rf $(BA)
	rm -rf $(BB)
	rm -rf $(BD)
	rm -rf $(CF)
	rm -rf $(CQ)
	rm -rf $(CT)
	rm -rf $(CZ)
	rm -rf $(IP)
	rm -rf $(IR)
	rm -rf $(IS)
	rm -rf $(OV)
	rm -rf $(PA)
	rm -rf $(PC)
	rm -rf $(PP)
	rm -rf $(PT)
	rm -rf $(QU)
	rm -rf $(VZ)
	rm -rf $(VN)
	rm -rf $(VO)
	rm -rf $(VU)
	rm -rf $(VV)
	rm -rf $(WG)
	rm -rf $(WP)
