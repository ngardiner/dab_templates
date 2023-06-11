
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap
	dab install perl-openssl-defaults libdrm-common libdrm2
	dab install apache2 apache2-bin libapache2-mod-php8.1 php8.1 libphp8.1-embed
	dab install libdbi-perl perl zoneminder
	dab install ffmpeg

	# Enable apache2 modules
	dab exec a2enmod cgi
	dab exec a2enconf zoneminder
	dab exec a2enmod rewrite

	# Enable run-once script
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
	cp ubuntu-18.04-zoneminder_18.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -f *.tar.gz
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
