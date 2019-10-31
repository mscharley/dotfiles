#!/usr/bin/env zsh

NVM_DIR="${NVM_DIR:-${XDG_CONFIG_HOME:-$HOME/opt}/nvm}"
if parent-ide > /dev/null; then
  # User-specific installation.
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  # Homebrew installation.
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use
else
  function nvm {
    unset -f nvm

    # User-specific installation.
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    # Homebrew installation.
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use

    if which nvm &> /dev/null; then
    else
      echo "Installing NVM..."
      git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
      pushd "$NVM_DIR" > /dev/null
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
      . "./nvm.sh" --no-use
      popd > /dev/null
    fi

    nvm "$@"
  }
fi
