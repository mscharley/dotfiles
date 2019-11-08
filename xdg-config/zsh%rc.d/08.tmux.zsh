#!/usr/bin/env zsh

# Historically this was in .zprofile, but that doesn't get loaded for non-login shells. zshrc is the right place for
# things that should run on all interactive shells.

# Don't use tmux unless we've been asked to.
if [[ $USE_TMUX != true ]]; then
  unset USE_TMUX
  return
fi

# Don't use tmux inside IDE's
if parent-ide > /dev/null; then
  unset USE_TMUX
  return
fi

# If tmux is not installed, then we definitely can't use it.
if ! command -v tmux &> /dev/null; then
  echo "WARNING: tmux integration was requested, but tmux is not installed." >&2
  unset USE_TMUX
  return
fi

if [[ -z $TMUX ]]; then
  unset USE_TMUX

  # Pause on login to SSH so we can still see any messages put out by the system
  if [[ -n $SSH_TTY ]]; then
    echo "Starting tmux in 5 seconds..."
    sleep 5
  fi

  export TMUX_TERM="$TERM"
  # Check if we have a running session already
  if tmux has -t login &> /dev/null; then
    OUTPUT=`tmux -2 attach -t login`
  else
    OUTPUT=`tmux -2 new -s login`
  fi

  if [[ $OUTPUT = "[exited]" ]]; then
    exit
  fi
  echo $OUTPUT
else
  unset USE_TMUX

  if [[ `tput -T${TMUX_TERM} colors` -ge 256 ]]; then
    export TERM="screen-256color"
  fi

  # We're inside tmux, so run our own startup script if there is one
  if [[ -f $ZDOTDIR/.zshrc.tmux ]]; then
    source $ZDOTDIR/.zshrc.tmux
  fi
fi
