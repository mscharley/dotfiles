#!/usr/bin/env bash

if [ -e /usr/sbin/transactional-update ]; then
	sudo transactional-update -d --continue pkg install -t pattern devel_basis
	sudo transactional-update -d --continue pkg install \
		zsh fish starship git gcc most kitty \
		fira-code-fonts symbols-only-nerd-fonts google-noto-sans-cjk-fonts \
		neovim fzf ripgrep fd bat wl-clipboard \
		libopenssl-devel
elif which zypper &> /dev/null; then
	sudo zypper install -t pattern devel_basis
	sudo zypper install \
		zsh fish starship git gcc most kitty \
		fira-code-fonts symbols-only-nerd-fonts google-noto-sans-cjk-fonts \
		neovim fzf ripgrep fd bat wl-clipboard \
		libopenssl-devel
fi

# Reset sudo access
sudo -k

function ensure-flatpak {
	if ! flatpak info --user "$1" &> /dev/null; then
		flatpak install --user "$1"
	fi
}

flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
ensure-flatpak com.github.tchx84.Flatseal
ensure-flatpak com.nextcloud.desktopclient.nextcloud
ensure-flatpak dev.deedles.Trayscale
