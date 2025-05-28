#!/usr/bin/env bash

if which rpm-ostree &> /dev/null; then
	for f in imports/fedora/yum.repos.d/*.repo; do
		if [ ! -e "/etc/yum.repos.d/$(basename $f)" ]; then
			echo ">> cp -i $f /etc/yum.repos.d/$f"
			sudo cp -i "$f" "/etc/yum.repos.d/$f"
		else
			echo "Refusing to overwrite yum repo $(basename $f)"
		fi
	done

	sudo rpm-ostree install --idempotent \
		fish kitty perl zsh \
		podman-compose steam-devices \
		1password 1password-cli mozilla-openh264 tailscale vim wl-clipboard
fi
