SHELL=/bin/bash

all:

deb:
	@echo 'Be sure to edit the changelog and /etc/version50!'
	@echo ''
	@echo 'Downloading latest CS50 plugins...'
	sudo rm -rf ide50/files/var/c9sdk/plugins/c9.ide.plugins/
	mkdir -p ide50/files/var/c9sdk/plugins/c9.ide.plugins/
	git clone --depth=1 git@github.com:cs50/ide50-plugin.git ide50/files/var/c9sdk/plugins/c9.ide.plugins
	rm -rf ide50/files/var/c9sdk/plugins/c9.ide.plugins/README.md
	rm -rf ide50/files/var/c9sdk/plugins/c9.ide.plugins/.git
	@echo 'Building Deb...'
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
	sudo rm -rf ide50/files/var/c9sdk/plugins/c9.ide.plugins/
