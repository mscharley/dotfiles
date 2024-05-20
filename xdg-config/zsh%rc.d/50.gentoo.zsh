#!/usr/bin/env zsh

if [ ! -f /etc/gentoo-release ]; then
  return
fi

alias distccmon-emerge="env DISTCC_DIR=/var/tmp/portage/.distcc watch -n 0.5 distccmon-text"
