#!/usr/bin/env zsh

# ZSH modules
zmodload zsh/mathfunc

# Setup paths
prepend-path $HOME/bin
prepend-path $HOME/.bin

if [[ -f /var/mail/$USER ]]; then
  MAILPATH=/var/mail/$USER
fi

# Load some overrides for bash scripts.
BASH_ENV="$HOME/.bashenv"

# Set a default CODE_HOME directory in case one hasn't been configured in zshenv
CODE_HOME=${CODE_HOME:-$HOME/Code}
