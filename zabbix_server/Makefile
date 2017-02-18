
BASEDIR:=$(shell dab basedir)
PKG=zabbix-server-mysql_3.2.3-1+xenial_amd64.deb
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap
	dab task mysql --password random
	wget http://repo.zabbix.com/zabbix/3.2/ubuntu/pool/main/z/zabbix/$(PKG) -o $(PKG)
	install -m 0600 $(PKG) ${BASEDIR}/tmp
	dpkg -i ${BASEDIR}/tmp/$(PKG)
	rm -f /tmp/$(PKG)

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
