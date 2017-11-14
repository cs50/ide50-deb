FILES_DIR := files
C9SDK_DIR := $(FILES_DIR)/var/c9sdk
CONFIGS_DIR := $(C9SDK_DIR)/configs/ide
OFFLINE_DIR := /tmp/ide50-offline
PLUGINS_DIR := $(C9SDK_DIR)/plugins
VERSION_FILE := $(FILES_DIR)/etc/version50

PLUGINS := audioplayer browser cat debug gist hex info presentation simple statuspage theme

NAME := ide50
VERSION := 126

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
	git clone --depth=1 git@github.com:cs50/ide50-offline.git "$(OFFLINE_DIR)"
	@cp "$(OFFLINE_DIR)"/files/workspace-cs50.js "$(CONFIGS_DIR)"

	@echo "\nBuilding Deb..."
	echo "version=$(VERSION)" > "$(VERSION_FILE)"

	# set permissions
	chmod -R 755 "$(FILES_DIR)/usr/bin/"
	chmod 644 "$(VERSION_FILE)" "$(FILES_DIR)/etc/profile.d/ide50.sh" "$(FILES_DIR)/home/ubuntu/.cs50/prompt"

	fpm \
	-C "$(FILES_DIR)" \
	--after-install postinst \
	--category misc \
	--deb-changelog changelog \
	--deb-no-default-config-files \
	--deb-priority optional \
	--depends \
		"apache2, \
		astyle (>= 3.0.1), \
		bc, \
		clang-3.8, \
		dnsutils, \
		dos2unix, \
		git (>= 1:2.13.0-0ppa1~ubuntu14.04.1), \
		git-lfs, \
		gdbserver, \
		inotify-tools, \
		libcs50 (>= 8.1.0-0ubuntu1), \
		libcs50-java (>= 2.0.2-0ubuntu1), \
		libphp-phpmailer, \
		libxslt1-dev, \
		manpages-dev, \
		ngrok-client, \
		nodejs, \
		openjdk-7-jdk, \
		php-cs50 (>= 6.0.0-0ubuntu1), \
		php5-cgi, \
		php5-curl, \
		php5-sqlite, \
		php5-xdebug, \
		phpliteadmin (>= 1.3.1), \
		sqlite3, \
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
	--description "installs necessary software on CS50 IDE" \
	--provides "$(NAME)" \
	--url "https://github.com/cs50" \
	.

clean:
	@echo "Cleaning up..."
	rm -rf *.deb "$(C9SDK_DIR)" "$(OFFLINE_DIR)" "$(VERSION_FILE)"
