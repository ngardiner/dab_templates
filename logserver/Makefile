
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
	dab install apache2 libapache2-mod-php7.0
	install -m 0666 jdk-8u121-linux-x64.tar.gz ${BASEDIR}/var/www/html/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz

	# Install loganalyzer under apache root
	install -m 0666 loganalyzer-4.1.5.tar.gz ${BASEDIR}/var/www/loganalyzer-4.1.5.tar.gz
	dab exec bash -c 'cd /var/www && tar xzf loganalyzer-4.1.5.tar.gz'
	dab exec bash -c 'mv /var/www/loganalyzer-4.1.5/src /var/www/html/loganalyzer'
	dab exec rm -rf /var/www/loganalyzer-4.1.5.tar.gz
	dab exec rm -rf /var/www/loganalyzer-4.1.5
	install -m 0655 config.php ${BASEDIR}/var/www/html/loganalyzer/config.php
	dab exec rm /var/www/html/loganalyzer/install.php
	dab exec chown -R www-data:www-data /var/www/html/loganalyzer

	# Install Oracle 8 and set JAVA_HOME which is a pre-requisite for
	# installation of logstash
	dab exec service apache2 start
	dab install oracle-java8-installer oracle-java8-set-default

	dab install logstash rsyslog rsyslog-elasticsearch rsyslog-gnutls
	dab install rsyslog-mysql rsyslog-relp

	# Clean up after installation
	dab exec rm -rf /var/www/html/otn-pub
	dab exec chown syslog:adm /var/log/syslog

	# Upload logstash configuration
	install -m 0644 10-input-syslog.conf ${BASEDIR}/etc/logstash/conf.d/10-input-syslog.conf
	install -m 0644 20-filter-syslog.conf ${BASEDIR}/etc/logstash/conf.d/20-filter-syslog.conf
	install -m 0644 30-output-es.conf ${BASEDIR}/etc/logstash/conf.d/30-output-es.conf

	# Upload rsyslog server configuration
	install -m 0644 00-server.conf ${BASEDIR}/etc/rsyslog.d/60-server.conf

	# Prepare firstrun scripts
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
ifeq ("$(wildcard loganalyzer-4.1.5.tar.gz)","")
	# Download LogAnalyzer
	wget -c -O "loganalyzer-4.1.5.tar.gz" --no-check-certificate http://download.adiscon.com/loganalyzer/loganalyzer-4.1.5.tar.gz
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
