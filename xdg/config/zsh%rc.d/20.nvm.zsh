#!/usr/bin/env zsh

if parent-ide > /dev/null; then
  # User-specific installation.
  [ -s "$NVM_HOME/nvm.sh" ] && . "$NVM_HOME/nvm.sh"
else
  function nvm {
    unset -f nvm

    # User-specific installation.
    [ -s "$NVM_HOME/nvm.sh" ] && . "$NVM_HOME/nvm.sh"

    if which nvm &> /dev/null; then
    else
      echo "Installing NVM..."
      git clone https://github.com/nvm-sh/nvm.git "$NVM_HOME"
      pushd "$NVM_HOME" > /dev/null
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
      . "./nvm.sh" --no-use
      popd > /dev/null
    fi

    nvm "$@"
  }
fi
