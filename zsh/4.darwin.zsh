#!/bin/zsh

if [[ `uname` != "Darwin" ]]; then
  return
fi

alias ls="ls -GF"
alias ll="ls -lah"
alias la="ls -A"
