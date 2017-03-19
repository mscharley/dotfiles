#!/usr/bin/env zsh

local git_opts=(--git-dir "$(realpath ${0:a:h}/..)/.git")
local UPDATES=$(git $git_opts log --oneline --no-patch origin/master..HEAD | wc -l)

if [[ $UPDATES -gt 0 ]]; then
  echo "${fg[yellow]}Updates for dotfiles detected.${terminfo[sgr0]}"
  echo
else
  git $git_opts fetch origin &> /dev/null &!
fi
