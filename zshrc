#!/bin/zsh

setopt ALL_EXPORT

# Load subscripts
for f in ~/.zsh/*.zsh; do
  [ -f $f ] && source $f
done

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

unsetopt ALL_EXPORT

if [ -f ~/.zsh/login ]; then
  source ~/.zsh/login
fi

