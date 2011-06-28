#!/bin/zsh

setopt ALL_EXPORT
setopt NULL_GLOB

# Load subscripts
for i in {1..99}; do
  for f in ~/.zsh/$i.*.zsh; do
    [ -f $f ] && source $f
  done
done

unsetopt NULL_GLOB
unsetopt ALL_EXPORT

if [ -f ~/.zsh/login ]; then
  source ~/.zsh/login
fi

