#!/bin/zsh

setopt ALL_EXPORT
setopt NULL_GLOB

# Load subscripts
for i in {1..99}; do
  for f in ~/.zsh/$i.*.zsh; do
    [ -f $f ] && source $f
  done
done

unset i
unset f
unsetopt NULL_GLOB
unsetopt ALL_EXPORT
