#!/usr/bin/env zsh

local UPDATES=$(git log --oneline --no-patch origin/master..HEAD | wc -l)

if [[ $UPDATES -gt 0 ]]; then
  echo "${fg[yellow]}Updates for dotfiles detected.${terminfo[sgr0]}"
  echo
else
  git --git-dir "$(realpath ${0:a:h}/..)/.git" fetch origin &> /dev/null &!
fi
