FILES_DIR := files
C9SDK_DIR := $(FILES_DIR)/var/c9sdk
CONFIGS_DIR := $(C9SDK_DIR)/configs
OFFLINE_DIR := /tmp/ide50-docker
PLUGINS_DIR := $(C9SDK_DIR)/plugins
VERSION_FILE := $(FILES_DIR)/etc/version50

PLUGINS := audioplayer cat debug gist info presentation simple theme

NAME := ide50
VERSION := 95

define getplugin
	@echo "\nFetching $(1)..."
	@plugin_dir="$(PLUGINS_DIR)/c9.ide.cs50.$(1)"; \
	mkdir -p "$$plugin_dir"; \
	git clone --depth=1 "git@github.com:cs50/harvard.cs50.$(1).git" "$$plugin_dir"; \
	rm -rf "$$plugin_dir/README.md" "$$plugin_dir/.git"*

endef

.PHONY: bash
bash:
	docker run -i --rm -t -v "$(PWD):/root" cs50/cli

.PHONY: deb
deb: clean Makefile
	@echo "\nDownloading latest CS50 plugins..."
	$(foreach plugin,$(PLUGINS),$(call getplugin,$(plugin)))

	@echo "\nFetching latest offline configs..."
	mkdir -p "$(CONFIGS_DIR)"
	git clone --depth=1 git@github.com:cs50/ide50-docker.git "$(OFFLINE_DIR)"
	@cp "$(OFFLINE_DIR)"/ide50-offline/files/client-workspace-cs50.js "$(CONFIGS_DIR)"

	@echo "\nBuilding Deb..."
	echo "version=$(VERSION)" > "$(VERSION_FILE)"

	# set permissions
	chmod -R 755 "$(FILES_DIR)/usr/bin/"
	chmod 644 "$(VERSION_FILE)" "$(FILES_DIR)/etc/profile.d/ide50.sh" "$(FILES_DIR)/home/ubuntu/.prompt50"

	fpm \
	-C "$(FILES_DIR)" \
	--after-install postinst \
	--category misc \
	--deb-changelog changelog \
	--deb-no-default-config-files \
	--deb-priority optional \
	--deb-recommends "bc, \
	check50, \
	clang-3.6, \
	dnsutils, \
	dos2unix, \
	gdbserver, \
	help50 (>= 1.2.2), \
	inotify-tools, \
	lib50-c (>= 7.1.1), \
	lib50-java (>= 1.1.1), \
	libphp-phpmailer, \
	library50-php, \
	manpages-dev, \
	ngrok-client, \
	nodejs, \
	openjdk-7-jdk, \
	php5-cgi, \
	php5-curl, \
	php5-sqlite, \
	php5-xdebug, \
	phpliteadmin (>= 1.1.1), \
	python-cs50 (>= 1.2.4), \
	python3-pip, \
	python3-tk, \
	render50, \
	sqlite3, \
	style50, \
	submit50 (>= 2.0.0), \
	telnet, \
	traceroute, \
	wamerican, \
	whois" \
	--license "" \
	--maintainer "CS50 <sysadmins@cs50.harvard.edu>" \
	-n "$(NAME)" \
	-s dir \
	-t deb \
	-v $(VERSION) \
	--vendor CS50 \
	--depends apache2 \
	--description "installs necessary software on CS50 IDE" \
	--provides "$(NAME)" \
	--url "" \
	.

clean:
	@echo "Cleaning up..."
	rm -rf *.deb "$(C9SDK_DIR)" "$(OFFLINE_DIR)" "$(VERSION_FILE)"
