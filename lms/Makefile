
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize prepare
all: info/init_ok prepare bootstrap global finalize

bootstrap:
	dab bootstrap

	install -m 0700 logitechmediaserver_7.9.0_amd64.deb ${BASEDIR}/tmp/logitechmediaserver_7.9.0_amd64.deb
	dab exec dpkg -i /tmp/logitechmediaserver_7.9.0_amd64.deb

	# Prepare firstrun scripts
	install -m 0700 runonce.sh ${BASEDIR}/etc/init.d/firstboot
	dab exec update-rc.d firstboot defaults
	install -m 0700 custom.sh ${BASEDIR}/tmp
	dab exec /bin/bash /tmp/custom.sh
	dab exec rm -f /tmp/custom.sh

finalize:
	dab finalize

prepare:
ifeq ("$(wildcard logitechmediaserver_7.9.0_amd64.deb)","")
	# Download the Logitech Media Server installer package
	wget -c -O "logitechmediaserver_7.9.0_amd64.deb" --no-check-certificate "http://downloads.slimdevices.com/LogitechMediaServer_v7.9.0/logitechmediaserver_7.9.0_amd64.deb"
endif

info/init_ok: dab.conf
	dab init
	touch $@

.PHONY: template
template:
	cp ubuntu-16.04-lms_16.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
