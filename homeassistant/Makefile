
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap
	# These are known packaged dependancies
	dab install build-essential netdiscover python3-aiohttp libmysqlclient-dev
	dab install python3-appdirs python3-chardet python3-dev python3-distro-info python3-fuzzywuzzy
	dab install python3-jinja2 python3-mutagen python3-netifaces python3-pip python3-six python3-sqlalchemy
	dab install python3-markupsafe python3-pyparsing python3-requests python3-setuptools
	dab install python3-tz python3-voluptuous python3-xmltodict python3-yaml python3-zeroconf
	pip3 install -d . homeassistant
	pip3 install -d . mysqlclient
	pip3 install -d . pycrypto
	install -m 0644 home-assistant@hass.service ${BASEDIR}/etc/systemd/system/home-assistant@hass.service
	install -m 0600 aiohttp-2.0.7.tar.gz ${BASEDIR}/tmp
	install -m 0600 appdirs-1.4.3-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 async_timeout-1.2.0-py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 chardet-3.0.2-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 homeassistant-0.43.2-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 Jinja2-2.9.6-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 MarkupSafe-1.0.tar.gz ${BASEDIR}/tmp
	install -m 0600 multidict-2.1.4.tar.gz ${BASEDIR}/tmp
	install -m 0600 mysqlclient-1.3.10.tar.gz ${BASEDIR}/tmp
	install -m 0600 packaging-16.8-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 pip-9.0.1-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 pycrypto-2.6.1.tar.gz ${BASEDIR}/tmp
	install -m 0600 pyparsing-2.2.0-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 pytz-2017.2-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 PyYAML-3.12.tar.gz ${BASEDIR}/tmp
	install -m 0600 requests-2.13.0-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 setuptools-35.0.2-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 six-1.10.0-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 typing-3.6.1.tar.gz ${BASEDIR}/tmp
	install -m 0600 voluptuous-0.9.3.tar.gz ${BASEDIR}/tmp
	install -m 0600 yarl-0.10.0.tar.gz ${BASEDIR}/tmp

	dab exec pip3 install --no-index --find-links=file:/tmp homeassistant mysqlclient pycrypto
	dab exec rm -f /tmp/*.whl
	dab exec rm -f /tmp/*.tar.gz
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
	cp ubuntu-16.04-homeassistant_16.04-1_amd64.tar.gz /var/lib/vz/template/cache

.PHONY: clean
clean:
	dab clean
	rm -f *.tar.gz
	rm -f *.whl
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
