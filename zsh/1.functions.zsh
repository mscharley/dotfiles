#!/usr/bin/env zsh

fpath=( ~/.zsh/functions "${fpath[@]}" )
for f in ~/.zsh/functions/*; do
  autoload -Uz $(basename $f)
done

