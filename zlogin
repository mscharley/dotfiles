#!/usr/bin/env zsh

if parent-ide > /dev/null; then
else
  which fortune &> /dev/null
  if [[ $? == 0 && -z $QUIET_STARTUP ]]; then
    fortune -a
    echo
  fi
fi

if [[ "$PROFILE_STARTUP" == true ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-
fi
