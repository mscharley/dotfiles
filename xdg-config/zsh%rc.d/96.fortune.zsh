#!/usr/bin/env zsh

if ! parent-ide &> /dev/null; then
  command -v fortune &> /dev/null
  if [[ $? == 0 && -z $QUIET_STARTUP ]]; then
    fortune -a
    echo
  fi
fi
