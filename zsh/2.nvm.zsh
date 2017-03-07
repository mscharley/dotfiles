#!/usr/bin/env zsh

# TODO: Slow, lazy load.
export NVM_DIR="$HOME/.nvm"
if which brew &> /dev/null; then
  NVM_DIR=$(brew --prefix nvm 2> /dev/null)
fi
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
