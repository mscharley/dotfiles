#!/usr/bin/env bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

for f in ~/.bash/*; do
  if [ -f $f ]; then
    source $f
  fi
done

# Include a local bashrc if one exists
if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

# Enable bash completion manually if needed.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
