#!/bin/zsh

if [[ `uname` != "Darwin" ]]; then
  return
fi

alias ls="ls -GF"
