#!/usr/bin/env zsh

if parent-ide > /dev/null; then
  return
fi

local git_opts=(--git-dir "$(realpath ${0:a:h}/..)/.git")
local UPDATES=$(git $git_opts log --oneline --no-patch origin/master...HEAD | wc -l)

if [[ $UPDATES -gt 0 ]]; then
  echo "${fg[yellow]}Updates for dotfiles detected.${terminfo[sgr0]}"
  echo
else
  git $git_opts fetch origin &> /dev/null &!
fi

if [[ -e /Applications/Alacritty.app ]]; then
  # Update our cached version once a day.
  if [[ ! -e ~/.alacritty-latest-version || "$(find ~/.alacritty-latest-version -mmin +1440)" ]]; then
    curl -s https://api.github.com/repos/jwilm/alacritty/tags | jq -r '.[].name' | head -n 1 | cut -c 2- > ~/.alacritty-latest-version
  fi
  if [[ -e ~/.alacritty-latest-version ]]; then
    /Applications/Alacritty.app/Contents/MacOS/alacritty --version | grep "$(cat ~/.alacritty-latest-version)$" &> /dev/null || \
      echo "${fg[yellow]}Updates for Alacritty detected.${terminfo[sgr0]}"$'\n'
  fi
fi
