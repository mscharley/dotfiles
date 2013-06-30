#!/bin/zsh

# Fudge for gnome terminal
if [[ "$COLORTERM" == 'gnome-terminal' && $TERM[0,6] != "screen" ]]; then
  export TERM='xterm-256color'
fi

