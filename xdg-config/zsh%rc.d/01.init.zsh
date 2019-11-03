#!/usr/bin/env zsh

# ZSH modules
zmodload zsh/mathfunc

fpath=( $ZDOTDIR/functions "${fpath[@]}" )
autoload -Uz $(for f in $ZDOTDIR/functions/*; do echo ${f##*/}; done)

# History controls
export HISTSIZE=${HISTSIZE:-1000}
export SAVEHIST=${SAVEHIST:-1000}

# Setup paths. Not all systems create a sane working path by default so lets make sure.
PATH=""
append-path $HOME/bin
append-path $HOME/.local/bin
append-path /usr/local/bin
append-path /usr/local/sbin
append-path /usr/sbin
append-path /usr/bin
append-path /sbin
append-path /bin

if [[ -f /var/mail/$USER ]]; then
  MAILPATH=/var/mail/$USER
fi

# Load some overrides for bash scripts.
BASH_ENV="$HOME/.bashenv"

# Set a default CODE_HOME directory in case one hasn't been configured in zshenv
CODE_HOME=${CODE_HOME:-$HOME/Code}
