#!/bin/zsh

setopt ALL_EXPORT

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# Load subscripts
for f in ~/.zsh/*.zsh; do
  [ -f $f ] && source $f
done

unsetopt ALL_EXPORT

if [ -f ~/.zsh/login ]; then
  source ~/.zsh/login
fi

