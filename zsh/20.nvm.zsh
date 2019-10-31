#!/usr/bin/env zsh

if parent-ide > /dev/null; then
  NVM_DIR="$HOME/.nvm"
  # User-specific installation.
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  # Homebrew installation.
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use
else
  function nvm {
    unset -f nvm

    NVM_DIR="$HOME/.nvm"
    # User-specific installation.
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    # Homebrew installation.
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use

    nvm "$@"
  }
fi
