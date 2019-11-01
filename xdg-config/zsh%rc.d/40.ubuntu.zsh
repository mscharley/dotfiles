#!/usr/bin/env zsh

# gentoo-release is just a text file, not a set of environment variables.
if [[ -e /etc/gentoo-release ]]; then
  return
fi

if [[ "$(for f in /dev/null /etc/*-release; do source $f &> /dev/null; done; echo $ID)" != "ubuntu" ]] ; then
  return
fi

prepend-path $HOME/.local/bin/ubuntu
