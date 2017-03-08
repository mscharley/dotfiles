#!/usr/bin/env zsh

which fortune 2>&1 > /dev/null
if [[ $? == 0 && -z $QUIET_STARTUP ]]; then
  fortune -a
  echo
fi

if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi
