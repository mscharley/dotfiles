#!/bin/zsh

setopt ALL_EXPORT
setopt NULL_GLOB

# Load subscripts
for i in {1..99}; do
  for f in ~/.zsh/$i.*.zsh; do
    [ -f $f ] && source $f
  done
done

# Load RVM into a shell session *as a function* if it exists
which append-path 2>&1 > /dev/null
if [[ $? == 0 && -d $HOME/.rvm ]]; then
  append-path $HOME/.rvm/bin
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

unset i
unset f
unsetopt NULL_GLOB
unsetopt ALL_EXPORT
