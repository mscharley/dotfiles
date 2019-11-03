#!/usr/bin/env zsh

if parent-ide > /dev/null; then
else
  command -v fortune &> /dev/null
  if [[ $? == 0 && -z $QUIET_STARTUP ]]; then
    fortune -a
    echo
  fi
fi

if [[ "$PROFILE_STARTUP" == true ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-

  echo "Profiling summary:"
  (head -n 1 $HOME/tmp/startlog.$$; tail -n 1 $HOME/tmp/startlog.$$)
fi
