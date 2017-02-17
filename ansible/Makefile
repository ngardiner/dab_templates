
BASEDIR:=$(shell dab basedir)

all: info/init_ok
	dab bootstrap
	dab install software-properties-common
	dab exec apt-add-repository ppa:ansible/ansible
	dab update
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
