#!/usr/bin/env zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -n "$(brew --prefix nvm 2> /dev/null)" ] && . "$(brew --prefix nvm)/nvm.sh"
