#!/usr/bin/env zsh

if [[ `uname` != "Darwin" ]]; then
  return
fi

if ! command -v gls &> /dev/null; then
  alias ls="ls -GF"
  alias ll="ls -la@h"
fi

function clear-quarantine {
  for attr in com.apple.metadata:kMDItemWhereFroms com.apple.metadata:kMDItemDownloadedDate com.apple.quarantine; do
    find "$1" -xattrname "$attr" -exec xattr -d "$attr" \{\} \;
  done
}

if [[ -d ~/Library/Python/2.7/bin ]] ; then
  append-path ~/Library/Python/2.7/bin
fi

function ram-disk {
  local BLOCKS=$(( ${1:?You must provide a size in MiB.} * 2048 ))
  diskutil erasevolume HFS+ "${2:-Ram Disk}" `hdiutil attach -nomount ram://${BLOCKS}`
}

append-path /usr/local/sbin
append-path /usr/local/bin
append-path /usr/sbin
append-path /sbin

function parallels-background-service {
  prlctl set "${1:?You must specify a VM to update.}" --on-window-close keep-running
}
