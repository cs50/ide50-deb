SHELL=/bin/bash

all:

prep1:
	sudo pkill mysqld || true
	sudo umount -lf build/chroot/dev/pts 2> /dev/null || true
	sudo umount -lf build/chroot/dev 2> /dev/null || true
	sudo umount -lf build/chroot/proc 2> /dev/null || true
	sudo umount -lf build/chroot/sys 2> /dev/null || true
	sudo rm -rf build/chroot
	mkdir -p build/chroot
	sudo debootstrap --arch=i386 trusty build/chroot
	sudo mount --bind /dev build/chroot/dev
	sudo cp scripts/install-script1 build/chroot/
	sudo chmod 700 build/chroot/install-script1
	sudo chroot build/chroot "./install-script1"
	sudo rm -rf build/chroot2
	sudo umount -lf build/chroot/dev/pts 2> /dev/null || true
	sudo umount -lf build/chroot/dev 2> /dev/null || true
	sudo umount -lf build/chroot/proc 2> /dev/null || true
	sudo umount -lf build/chroot/sys 2> /dev/null || true
	sudo mv build/chroot build/chroot2

prep2:
	sudo pkill mysqld || true
	sudo umount -lf build/chroot/dev/pts 2> /dev/null || true
	sudo umount -lf build/chroot/dev 2> /dev/null || true
	sudo umount -lf build/chroot/proc 2> /dev/null || true
	sudo umount -lf build/chroot/sys 2> /dev/null || true
	sudo rm -rf build/chroot
	sudo cp -rp build/chroot2 build/chroot
	sudo mount --bind /dev build/chroot/dev
	sudo cp scripts/install-script2 build/chroot/
	sudo chmod 700 build/chroot/install-script2
	sudo chroot build/chroot "./install-script2"
	sudo rm build/chroot/install-script{1,2}
	sudo umount -lf build/chroot/dev

post:
	sudo scripts/post-work

deb:
	@echo 'Be sure to edit the changelog and /etc/appliance50!'
	cd appliance50-2014 && sudo dpkg-buildpackage -us -uc > /dev/null
	rm -rf build/deb
	mkdir -p build/deb
	mv appliance50_2014-* build/deb

host:
	sudo apt-get install debootstrap dpkg-dev debhelper syslinux squashfs-tools genisoimage
	sudo apt-get remove mysql-server apache2
	sudo apt-get autoremove

chroot:
	scripts/quick-chroot

reinstall:
	sudo scripts/chroot-setup && sudo chroot build/chroot /bin/bash -c "apt-get update && apt-get install --reinstall appliance50"

clean:
	sudo umount -lf build/chroot/dev/pts 2> /dev/null || true
	sudo umount -lf build/chroot/dev 2> /dev/null || true
	sudo umount -lf build/chroot/proc 2> /dev/null || true
	sudo umount -lf build/chroot/sys 2> /dev/null || true
	sudo rm -rf build
