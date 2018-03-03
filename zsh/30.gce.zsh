#!/usr/bin/env zsh

for f in $HOME/opt/google-cloud-sdk /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk; do
  if [[ -d "$f" ]]; then
    source $f/path.zsh.inc
    source $f/completion.zsh.inc
  fi
done
