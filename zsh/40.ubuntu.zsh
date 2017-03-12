#!/usr/bin/env zsh

if [[ "$(source /dev/null /etc/*-release; echo $ID)" != "ubuntu" ]] ; then
  return
fi

prepend-path $HOME/.bin/ubuntu
