
BASEDIR:=$(shell dab basedir)

all: info/init_ok
	dab bootstrap
<<<<<<< HEAD
	dab install software-properties-common
	dab exec apt-add-repository ppa:ansible/ansible
	dab update
=======
>>>>>>> cdeb30b537af4d02d82b35fd997e82cc88bd1f24
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
