#!/usr/bin/env zsh

# Configure XDG defaults explicitly.
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Backport XDG into applications that can support it implicitly through configuration.

if [[ -d $HOME/Library/Android/sdk ]]; then
  ANDROID_HOME="$HOME/Library/Android/sdk"
else
  ANDROID_HOME="${XDG_CONFIG_HOME:-$HOME/opt}/android"
fi

DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
ELINKS_CONFDIR="${XDG_CONFIG_HOME}/elinks"
ICEAUTHORITY="${XDG_CACHE_HOME}/ICEauthority"
VIMINIT=":source ${XDG_CONFIG_HOME}/vim/vimrc"

NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
NVM_HOME="${NVM_DIR:-${XDG_DATA_HOME}/nvm}"
NVM_DIR="${NVM_DIR:-${XDG_CACHE_HOME}/nvm}"
