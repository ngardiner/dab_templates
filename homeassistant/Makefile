
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global finalize
all: info/init_ok bootstrap global finalize

bootstrap:
	dab bootstrap
	dab install python3-pip python3-dev python3-setuptools
	pip3 install -d . homeassistant
	install -m 0644 home-assistant@hass.service ${BASEDIR}/etc/systemd/system/home-assistant@hass.service
	install -m 0600 aiohttp-1.3.1.tar.gz ${BASEDIR}/tmp
	install -m 0600 appdirs-1.4.0-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 async_timeout-1.1.0-py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 chardet-2.3.0-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 homeassistant-0.38.3-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 Jinja2-2.9.5-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 MarkupSafe-0.23.tar.gz ${BASEDIR}/tmp
	install -m 0600 multidict-2.1.4.tar.gz ${BASEDIR}/tmp
	install -m 0600 packaging-16.8-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 pip-9.0.1-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 pyparsing-2.1.10-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 pytz-2016.10-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 PyYAML-3.12.tar.gz ${BASEDIR}/tmp
	install -m 0600 requests-2.13.0-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 setuptools-34.2.0-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 six-1.10.0-py2.py3-none-any.whl ${BASEDIR}/tmp
	install -m 0600 typing-3.5.3.0.tar.gz ${BASEDIR}/tmp
	install -m 0600 voluptuous-0.9.3.tar.gz ${BASEDIR}/tmp
	install -m 0600 yarl-0.9.8.tar.gz ${BASEDIR}/tmp
	dab exec pip3 install --no-index --find-links=file:/tmp homeassistant
	dab exec rm -f /tmp/*.whl
	dab exec rm -f /tmp/*.tar.gz
	install -m 0700 runonce.sh ${BASEDIR}/etc/init.d/firstboot
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
