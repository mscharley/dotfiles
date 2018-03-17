#!/usr/bin/env zsh

if parent-ide > /dev/null; then
  export NVM_DIR="$HOME/.nvm"
  # User-specific installation.
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  # Homebrew installation.
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
else
  function nvm {
    unset -f nvm

    export NVM_DIR="$HOME/.nvm"
    # User-specific installation.
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    # Homebrew installation.
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

    nvm "$@"
  }
fi
