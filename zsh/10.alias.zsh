#!/bin/zsh

# Directory listings
if [[ -z `alias ls` ]]; then
  alias ls="ls --color=auto -F"
  alias ll="ls -lah"
  alias la="ls -A"
fi

alias mem="free -m"

alias sass="sass -t expanded --no-cache --unix-newlines -l --debug-info -E utf-8"
alias sassw="sass --watch sass:css"
alias touchsass="find ./ -iname \"*.scss\" -exec touch \{\} \;"

# Open web addresses in the browser if one was set in zshrc.local
if [[ -n $BROWSER ]]; then
  alias -s html=$BROWSER
  alias -s org=$BROWSER
  alias -s com=$BROWSER
  alias -s net=$BROWSER
fi

