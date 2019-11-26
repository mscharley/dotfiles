#!/usr/bin/env zsh

if [[ "$PROFILE_STARTUP" == true ]]; then
  mkdir -p $HOME/tmp
  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  PS4=$'%D{%M:%S.%6.} %N:%i> '
  exec 3>&2 2>$HOME/tmp/startlog.$$
  setopt xtrace prompt_subst
fi
