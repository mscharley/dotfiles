#!/usr/bin/env zsh

# Setup paths
prepend-path $HOME/bin
prepend-path $HOME/.bin

if [[ -f /var/mail/$USER ]]; then
  export MAILPATH=/var/mail/$USER
fi
