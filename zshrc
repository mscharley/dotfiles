#!/bin/zsh

setopt ALL_EXPORT

# Load subscripts
for f in ~/.zsh/*.zsh; do
  [[ -f $f ]] && source $f
done

unsetopt ALL_EXPORT

