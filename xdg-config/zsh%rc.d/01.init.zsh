#!/usr/bin/env zsh

# ZSH modules.
zmodload zsh/mathfunc
autoload -U compinit
autoload colors zsh/terminfo

# Load color constants
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi

# Function paths.
fpath=( $ZDOTDIR/functions "${fpath[@]}" )
autoload -Uz $(for f in $ZDOTDIR/functions/*; do echo ${f##*/}; done)

# History controls.
export HISTSIZE=${HISTSIZE:-1000}
export SAVEHIST=${SAVEHIST:-1000}

# Setup paths. Not all systems create a sane working path by default so lets make sure.
# PATH=""
prepend-path $XDG_BIN_HOME
prepend-path $HOME/opt/bin
append-path /usr/local/bin
append-path /usr/local/sbin
append-path /usr/sbin
append-path /usr/bin
append-path /sbin
append-path /bin

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
  MAILPATH=/var/mail/$USER
fi

# Load some overrides for bash scripts.
BASH_ENV="$HOME/.bashenv"

# Set a default CODE_HOME directory in case one hasn't been configured in zshenv
CODE_HOME=${CODE_HOME:-$HOME/Code}
