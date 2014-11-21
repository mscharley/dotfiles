#!/bin/zsh

if [[ `uname` != "Darwin" ]]; then
  return
fi

if [[ -e /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

alias ls="ls -GF"
alias ll="ls -la@h"

prepend-path /usr/local/bin
prepend-path /usr/sbin
prepend-path /sbin
