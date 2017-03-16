#!/usr/bin/env zsh

local UPDATES=$(git diff --name-only origin/master..HEAD | wc -l)

if [[ $UPDATES -gt 0 ]]; then
  echo $PR_YELLOW"Updates for dotfiles detected."$PR_NO_COLOR
  echo
else
  git --git-dir "$(realpath ${0:a:h}/..)/.git" fetch origin &> /dev/null &!
fi
