#!/usr/bin/env bash

if [ -e /usr/sbin/transactional-update ]; then
	sudo transactional-update --continue pkg install \
		zsh fish starship git gcc most kitty \
		fira-code-fonts symbols-only-nerd-fonts google-noto-sans-cjk-fonts \
		neovim fzf ripgrep fd bat
elif which zypper &> /dev/null; then
	sudo zypper install \
		zsh fish starship git gcc most kitty \
		fira-code-fonts symbols-only-nerd-fonts google-noto-sans-cjk-fonts \
		neovim fzf ripgrep fd bat
fi

# Reset sudo access
sudo -k
