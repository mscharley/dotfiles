#!/bin/zsh

PARENT_PROC=$(ps -o command -p `get-ppid $$` | tail -n +2)

## Don't use tmux inside IDE's

# IDEA
if string-contains "com.intellij.idea.Main" "$PARENT_PROC"; then
  unset USE_TMUX
fi

if string-contains ".app/Contents/MacOS/idea" "$PARENT_PROC"; then
  unset USE_TMUX
fi

# Kate
if [[ -n $KATE_PID ]]; then
  unset USE_TMUX
fi

unset PARENT_PROC

# If we're already in tmux, then don't try to nest a new session
if [[ -z $TMUX && $TERM[0,6] == "screen" ]]; then
  unset USE_TMUX
fi

if [[ -z $TMUX ]]; then
  if [[ $USE_TMUX != true || -z `which tmux` ]]; then
    unset USE_TMUX
    return
  fi
  unset USE_TMUX

  # Pause on login to SSH so we can still see any messaages put
  # out by the system
  if [[ -n $SSH_TTY ]]; then
    echo "Starting tmux..."
    sleep 5
  fi

  export TMUX_TERM="$TERM"
  # Check if we have a running session already
  tmux has -t login 2> /dev/null
  if [[ $? -eq 0 ]]; then
    OUTPUT=`tmux -2 attach -t login`
  else
    OUTPUT=`tmux -2 new -s login`
  fi

  if [[ $OUTPUT = "[exited]" ]]; then
    exit
  fi
  echo $OUTPUT
elif [[ $USE_TMUX == true ]]; then
  unset USE_TMUX

  if [[ `tput -T${TMUX_TERM} colors` -ge 256 ]]; then
    export TERM="screen-256color"
  fi

  # We're inside tmux, so run our own startup script if there is one
  if [[ -f ~/.zshrc.tmux ]]; then
    source ~/.zshrc.tmux
  fi
fi

which fortune 2>&1 > /dev/null
if [[ $? == 0 && -z $QUIET_STARTUP ]]; then
  fortune -a
  echo
fi
