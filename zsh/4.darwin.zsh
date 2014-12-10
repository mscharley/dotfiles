#!/bin/zsh

if [[ `uname` != "Darwin" ]]; then
  return
fi

if [[ -e /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

alias ls="ls -GF"
alias ll="ls -la@h"

alias clear-quarantine="find . -xattrname com.apple.quarantine -exec xattr -d com.apple.quarantine \{\} \;"

prepend-path /usr/local/bin
prepend-path /usr/sbin
prepend-path /sbin
