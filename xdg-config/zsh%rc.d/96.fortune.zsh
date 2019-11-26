#!/usr/bin/env zsh

if ! parent-ide &> /dev/null; then
  command -v fortune &> /dev/null
  if [[ $? == 0 && -z $QUIET_STARTUP ]]; then
    if [[ -n $FORTUNE_OPTS ]]; then
      fortune ${=FORTUNE_OPTS}
    else
      fortune -s fortunes computers pets science
    fi
    echo
  fi
fi

unset FORTUNE_OPTS
