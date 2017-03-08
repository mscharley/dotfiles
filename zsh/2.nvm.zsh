#!/usr/bin/env zsh

# TODO: Slow, lazy load.

export NVM_DIR="$HOME/.nvm"
# User-specific installation.
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# Homebrew installation.
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
