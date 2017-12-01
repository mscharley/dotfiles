#!/usr/bin/env zsh

# ZSH modules
zmodload zsh/mathfunc

# Setup paths
prepend-path $HOME/bin
prepend-path $HOME/.bin

if [[ -f /var/mail/$USER ]]; then
  export MAILPATH=/var/mail/$USER
fi

# Load some overrides for bash scripts.
export BASH_ENV="$HOME/.bashenv"
