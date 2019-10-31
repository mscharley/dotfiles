#!/usr/bin/env zsh

if [[ -d /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

autoload -U compinit
if [[ ! -d $XDG_CACHE_HOME/zsh ]]; then
  mkdir -p $XDG_CACHE_HOME/zsh
fi
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt completealiases
