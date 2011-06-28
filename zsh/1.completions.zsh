#!/bin/zsh

autoload -U compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true

setopt completealiases

