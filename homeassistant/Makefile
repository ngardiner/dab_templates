
BASEDIR:=$(shell dab basedir)

all: info/init_ok
	dab bootstrap
	dab install python-pip python3-dev
	dab exec pip3 install homeassistant
	install -m 0644 home-assistant@hass.service ${BASEDIR}/etc/systemd/system/home-assistant@hass.service
	dab finalize

info/init_ok: dab.conf
	dab init
	touch $@

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~
