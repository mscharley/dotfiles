#!/usr/bin/env zsh

if parent-ide > /dev/null; then
  return
fi

local dotfiles_dir="$(realpath ${0:a:h}/..)/.git"
if [[ ! -e "$dotfiles_dir" ]]; then
  return
fi

local git_opts=(--git-dir "$dotfiles_dir")
local UPDATES=$(git $git_opts log --oneline --no-patch origin/master...HEAD | wc -l)

if [[ $UPDATES -gt 0 ]]; then
  echo "${fg[yellow]}Updates for dotfiles detected.${terminfo[sgr0]}"
  echo
else
  git $git_opts fetch origin &> /dev/null &!
fi