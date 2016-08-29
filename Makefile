SHELL=/bin/bash

PLUGINS := audioplayer cat debug gist info presentation previewer simple theme

define getplugin
	@echo "Fetching $(1) plugin..."
	pdir=ide50/files/var/c9sdk/plugins/c9.ide.cs50.$(1) ;\
	mkdir -p $$pdir ;\
	git clone --depth=1 git@github.com:cs50/harvard.cs50.$(1).git $$pdir ;\
	rm -rf $(pdir)/README.md ;\
	rm -rf $(pdir)/.git*
endef

all:

deb:
	@echo 'Be sure to edit the changelog and /etc/version50!'
	@echo ''
	@echo 'Downloading latest CS50 plugins...'
	rm -rf ide50/files/var/c9sdk/plugins/
	$(foreach plugin,$(PLUGINS),$(call getplugin,$(plugin)))
ifneq ($(filter debug,$(PLUGINS)),)
	@echo 'Updating debug50 script'
	mkdir -p ide50/files/home/ubuntu/bin
	cp ide50/files/var/c9sdk/plugins/c9.ide.cs50.debug/bin/debug50 ide50/files/home/ubuntu/bin
endif
	@echo 'Fetching latest offline config file...'
	rm -rf /tmp/ide50-docker
	mkdir -p ide50/files/var/c9sdk/configs
	git clone --depth=1 git@github.com:cs50/ide50-docker.git /tmp/ide50-docker
	cp /tmp/ide50-docker/ide50-offline/files/client-workspace-cs50.js ide50/files/var/c9sdk/configs/
	@echo 'Building Deb...'
	cd ide50 && dpkg-buildpackage -us -uc > /dev/null
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
	sudo rm -rf ide50/files/home/ubuntu/bin/
	sudo rm -rf /tmp/ide50-docker
