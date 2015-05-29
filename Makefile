SHELL=/bin/bash

all:

deb:
	@echo 'Be sure to edit the changelog and /etc/version50!'
	cd ide50 && sudo dpkg-buildpackage -us -uc > /dev/null
	rm -rf build/deb
	mkdir -p build/deb
	mv ide50_* build/deb

clean:
	sudo umount -lf build/chroot/dev/pts 2> /dev/null || true
	sudo umount -lf build/chroot/dev 2> /dev/null || true
	sudo umount -lf build/chroot/proc 2> /dev/null || true
	sudo umount -lf build/chroot/sys 2> /dev/null || true
	sudo rm -rf build
	sudo rm -rf ide50/debian/ide50
