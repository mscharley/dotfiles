#!/usr/bin/env zsh

if [[ "$(for f in /dev/null /etc/*-release; do source $f; done; echo $ID)" != "ubuntu" ]] ; then
  return
fi

prepend-path $HOME/.bin/ubuntu
