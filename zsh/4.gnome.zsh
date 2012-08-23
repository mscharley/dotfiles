#!/bin/zsh

# Fudge for gnome terminal
if [[ $COLOR_TERM == 'gnome-term' ]]; then
  export TERM='xterm-256color'
fi

