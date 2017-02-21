
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap
	dab install byobu libmodule-build-perl libcpan-meta-perl libcpan-meta-requirements-perl
	dab install libcpan-meta-yaml-perl libmodule-metadata-perl libversion-perl sshfs
	dab install apache2 build-essential cpanminus curl git git-core nodejs npm perl
	dab install php7.0-dev php7.0-cli php7.0-curl php7.0-ldap php7.0-mysql 
	dab install php7.0-sqlite3 python3 python3-pip vim
	install -m 0700 runonce.sh ${BASEDIR}/etc/init.d/firstboot
	dab exec update-rc.d firstboot defaults
	install -m 0700 custom.sh ${BASEDIR}/tmp
	dab exec /bin/bash /tmp/custom.sh
	dab exec rm -f /tmp/custom.sh
	mknod -m 0666 ${BASEDIR}/dev/fuse c 10 229

finalize:
	dab finalize

info/init_ok: dab.conf
	dab init
	touch $@

.PHONY: template
template:
	cp ubuntu-16.04-devbox_16.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
