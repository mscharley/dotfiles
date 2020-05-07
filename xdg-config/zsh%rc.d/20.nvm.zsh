#!/usr/bin/env zsh

if parent-ide > /dev/null; then
  # User-specific installation.
  [ -s "$NVM_HOME/nvm.sh" ] && . "$NVM_HOME/nvm.sh"
else
  function useNvm {
    if [[ -f .nvmrc ]]; then
      if command -v nvm &> /dev/null; then
        nvm use
      fi
    fi
  }
  typeset -a chpwd_functions
  chpwd_functions+='useNvm'

  function nvm {
    unset -f nvm

    # User-specific installation.
    [ -s "$NVM_HOME/nvm.sh" ] && . "$NVM_HOME/nvm.sh"

    if ! command -v nvm &> /dev/null; then
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
