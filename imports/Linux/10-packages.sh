#!/usr/bin/env bash

if which zypper &> /dev/null; then
	sudo zypper install \
		fish starship most kitty \
		fira-code-fonts symbols-only-nerd-fonts google-noto-sans-cjk-fonts \
		neovim fzf ripgrep fd bat
fi

# Reset sudo access
sudo -k
