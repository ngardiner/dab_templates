
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap

	# Set package options to skip Java 8 license agreement prompt
	dab install debconf-utils
	install -m 0700 oracle-prereq.sh ${BASEDIR}/tmp/oracle-prereq.sh
	dab exec /tmp/oracle-prereq.sh

	# Install Oracle 8 and set JAVA_HOME which is a pre-requisite for
	# installation of logstash
	dab install oracle-java8-installer
	dab exec echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/environment

	dab install logstash rsyslog rsyslog-elasticsearch rsyslog-gnutls
	dab install rsyslog-mysql rsyslog-relp
	install -m 0700 00-server.conf ${BASEDIR}/etc/rsyslog.d/00-server.conf
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
	cp ubuntu-16.04-logserver_16.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
