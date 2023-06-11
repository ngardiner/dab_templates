
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap
	dab install fping libiksemel3 libodbc1 mysql-client mysql-server mysql-common
	dab install zabbix-server-mysql
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
	cp ubuntu-16.04-zabbix-server_16.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -rf *.deb
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
