#!/usr/bin/env zsh

# ZSH modules.
zmodload zsh/mathfunc
autoload -U compinit
autoload colors zsh/terminfo
autoload -U add-zsh-hook

# Load color constants
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi

# Function paths.
fpath=( $ZDOTDIR/functions "${fpath[@]}" )
autoload -Uz $(for f in $ZDOTDIR/functions/*; do echo ${f##*/}; done)

# History controls.
export HISTFILE=$XDG_DATA_HOME/zsh/history
export HISTSIZE=${HISTSIZE:-1000}
export SAVEHIST=${SAVEHIST:-10000}

# Setup paths. Not all systems create a sane working path by default so lets make sure.
prepend-path $HOME/opt/bin
prepend-path $XDG_BIN_HOME
append-path /usr/local/bin
append-path /usr/local/sbin
append-path /usr/bin
append-path /usr/sbin
append-path /bin
append-path /sbin

if [[ `uname` = "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -d $HOME/bin ]]; then
  echo -n "${fg[red]}"
  echo "$HOME/bin is deprecated. It is currently in your \$PATH still but you should do one of the following:"
  echo ""
  echo "1. move the files to $XDG_BIN_HOME"
  echo "2. set \$XDG_BIN_HOME to $HOME/bin and reinstall your dotfiles"
  echo "3. move the files to $HOME/opt/bin"
  echo "${terminfo[sgr0]}"

  prepend-path $HOME/bin
fi

if [[ -f /var/mail/$USER ]]; then
  export MAILPATH=/var/mail/$USER
fi

# Load some overrides for bash scripts.
export BASH_ENV="$HOME/.bashenv"

# Set a default CODE_HOME directory in case one hasn't been configured in zshenv
export CODE_HOME=${CODE_HOME:-$HOME/Code}

# Configure xz compression to smartly use available processing capacity
export XZ_DEFAULTS="-T 0"
