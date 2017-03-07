#!/usr/bin/env zsh

if [[ -d /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

fpath=( ~/.zsh/functions "${fpath[@]}" )
autoload -Uz $(for f in ~/.zsh/functions/*; do echo ${f##*/}; done)

autoload -U compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true

setopt completealiases
