#!/bin/zsh

if [[ `uname` != "Darwin" ]]; then
  return
fi

alias ls="ls -GF"
prepend-path /usr/local/bin
prepend-path /usr/sbin
prepend-path /sbin
