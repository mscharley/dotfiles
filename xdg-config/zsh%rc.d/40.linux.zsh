#!/usr/bin/env zsh

if [[ `uname` != "Linux" ]]; then
  return
fi

# After deleting my crontab yet again...
alias crontab="crontab -i"
