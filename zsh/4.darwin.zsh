#!/bin/zsh

if [[ `uname` != "Darwin" ]]; then
  return
fi

alias ls="ls -GF"
PATH=$HOME/bin:$HOME/.bin:/usr/local/bin:$PATH
