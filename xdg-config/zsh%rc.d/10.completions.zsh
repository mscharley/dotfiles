#!/usr/bin/env zsh

if [[ ! -d $XDG_CACHE_HOME/zsh ]]; then
  mkdir -p $XDG_CACHE_HOME/zsh
fi
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt completealiases

if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi
