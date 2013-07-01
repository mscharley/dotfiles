#!/bin/zsh

# Load RVM into a shell session *as a function* if it exists
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

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
