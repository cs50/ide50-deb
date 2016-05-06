SHELL=/bin/bash

all:

deb:
	@echo 'Be sure to edit the changelog and /etc/version50!'
	@echo ''
	@echo 'Downloading latest CS50 plugins...'
	sudo rm -rf ide50/files/var/c9sdk/plugins/
	mkdir -p ide50/files/var/c9sdk/plugins/
	git clone --depth=1 git@github.com:cs50/ide50-plugins.git ide50/files/var/c9sdk/plugins/
	rm -rf ide50/files/var/c9sdk/plugins/README.md
	rm -rf ide50/files/var/c9sdk/plugins/.git*
	@echo 'Fetching latest offline config file...'
	sudo rm -rf /tmp/ide50-docker
	mkdir -p ide50/files/var/c9sdk/configs
	git clone --depth=1 git@github.com:cs50/ide50-docker.git /tmp/ide50-docker
	cp /tmp/ide50-docker/ide50-offline/files/client-workspace-cs50.js ide50/files/var/c9sdk/configs/
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
	sudo rm -rf ide50/files/var/c9sdk/plugins/
	sudo rm -rf /tmp/ide50-docker
