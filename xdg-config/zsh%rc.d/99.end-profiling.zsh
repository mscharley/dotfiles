#!/usr/bin/env zsh

# Source .profile for basic environment variables
if [ -f ~/.profile ]; then
  emulate sh -c '. ~/.profile'
fi
