#!/usr/bin/env bash

if ! command -v brew &> /dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew bundle --file=configs/xdg/config/homebrew%Brewfile --no-upgrade
