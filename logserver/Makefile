
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize prepare
all: info/init_ok prepare bootstrap global finalize

bootstrap:
	dab bootstrap

	# Set package options to skip Java 8 license agreement prompt
	dab install debconf-utils
	install -m 0700 oracle-prereq.sh ${BASEDIR}/tmp/oracle-prereq.sh
	dab exec /tmp/oracle-prereq.sh

	# Install Apache now, because we'll use it to avoid having to have
	# internet access for the Java installation
	dab install apache2
	dab exec mkdir -p /var/www/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441
	install -m 0700 jdk-8u121-linux-x64.tar.gz ${BASEDIR}/var/www/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz

	# Install Oracle 8 and set JAVA_HOME which is a pre-requisite for
	# installation of logstash
	dab exec service apache2 start
	dab install oracle-java8-installer oracle-java8-set-default

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

prepare:
ifeq ("$(wildcard jdk-8u121-linux-x64.tar.gz)","")
	# Download the JDK binary in preparation for use during install
	wget -c -O "jdk-8u121-linux-x64.tar.gz" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz"
endif

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
