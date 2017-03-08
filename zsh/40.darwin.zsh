#!/usr/bin/env zsh

if [[ `uname` != "Darwin" ]]; then
  return
fi

if [[ -e /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

alias ls="ls -GF"
alias ll="ls -la@h"

function clear-quarantine {
  for attr in com.apple.metadata:kMDItemWhereFroms com.apple.metadata:kMDItemDownloadedDate com.apple.quarantine; do
    find "$1" -xattrname "$attr" -exec xattr -d "$attr" \{\} \;
  done
}

if [[ -d ~/Library/Python/2.7/bin ]] ; then
  append-path ~/Library/Python/2.7/bin
fi

alias gpg="gpg2"

append-path /usr/local/sbin
append-path /usr/local/bin
append-path /usr/sbin
append-path /sbin
