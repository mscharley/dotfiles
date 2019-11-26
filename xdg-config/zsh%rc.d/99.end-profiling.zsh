#!/usr/bin/env zsh

if [[ "$PROFILE_STARTUP" == true ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-

  echo "Profiling summary:"
  (head -n 1 $HOME/tmp/startlog.$$; tail -n 1 $HOME/tmp/startlog.$$)
fi
