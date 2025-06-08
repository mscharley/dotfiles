#!/usr/bin/env bash

if command -v brew &> /dev/null; then
	brew bundle --file=configs/xdg/config/homebrew%Brewfile --no-upgrade
fi
