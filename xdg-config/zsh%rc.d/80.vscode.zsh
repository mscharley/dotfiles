#!/usr/bin/env zsh

if [[ -d ~/.var/app/com.visualstudio.code/ ]]; then
	alias code="flatpak run com.visualstudio.code"
fi
