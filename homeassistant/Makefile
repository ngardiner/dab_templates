
BASEDIR:=$(shell dab basedir)
include ../Makefile.global

.PHONY: bootstrap global
all: info/init_ok bootstrap global

bootstrap:
	dab bootstrap
	dab install python3-pip python3-dev
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
	dab exec pip3 install --no-index --find-links=file:/tmp homeassistant
	dab finalize

#-rw-r--r-- 1 root root 1254803 Feb 17 10:18 pip-9.0.1-py2.py3-none-any.whl
#-rw-r--r-- 1 root root   56164 Feb 17 10:18 pyparsing-2.1.10-py2.py3-none-any.whl
#-rw-r--r-- 1 root root  483510 Feb 17 10:18 pytz-2016.10-py2.py3-none-any.whl
#-rw-r--r-- 1 root root  253011 Feb 17 10:18 PyYAML-3.12.tar.gz
#-rw-r--r-- 1 root root  584556 Feb 17 10:18 requests-2.13.0-py2.py3-none-any.whl
#-rw-r--r-- 1 root root  389354 Feb 17 10:18 setuptools-34.2.0-py2.py3-none-any.whl
#-rw-r--r-- 1 root root   10341 Feb 17 10:18 six-1.10.0-py2.py3-none-any.whl
#-rw-r--r-- 1 root root   60350 Feb 17 10:18 typing-3.5.3.0.tar.gz
#-rw-r--r-- 1 root root   34097 Feb 17 10:18 voluptuous-0.9.3.tar.gz
#-rw-r--r-- 1 root root  125806 Feb 17 10:18 yarl-0.9.8.tar.gz

info/init_ok: dab.conf
	dab init
	touch $@

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
