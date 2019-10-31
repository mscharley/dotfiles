#!/usr/bin/env zsh

if [[ -d /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

autoload -U compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt completealiases
