#!/usr/bin/env bash

if [ -e /usr/sbin/transactional-update ]; then
	sudo transactional-update -d --continue pkg install -t pattern devel_basis
	sudo transactional-update -d --continue pkg install \
		zsh fish starship git gcc most \
		neovim fzf ripgrep fd bat \
		libopenssl-devel
elif which zypper &> /dev/null; then
	sudo zypper install -t pattern devel_basis
	sudo zypper install \
		zsh fish starship git gcc most \
		neovim fzf ripgrep fd bat \
		libopenssl-devel
fi

# Reset sudo access
sudo -k
