#!/usr/bin/env zsh

if [[ ! -d ~/opt/flutter ]]; then
  alias flutter="open https://flutter.io/sdk-archive/"
else
  append-path $HOME/opt/flutter/bin
fi
