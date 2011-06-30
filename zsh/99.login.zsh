#!/bin/zsh

if [[ ($TERM != "screen") && ($TERM != "tmux") ]]; then
  if [[ -z $USE_TMUX || -z `which tmux` ]]; then
    return
  fi
  unset $USE_TMUX

  # Pause on login to SSH so we can still see any messaages put
  # out by the system
  if [[ -n $SSH_TTY ]]; then
    echo "Starting tmux..."
    sleep 5
  fi

  # Check if we have a running session already
  tmux has -t login 2> /dev/null
  if [[ $? -eq 0 ]]; then
    exec tmux attach -t login
  else
    exec tmux new -s login
  fi
else
  # We're inside tmux, so run our own startup script if there is one
  if [[ -f ~/.zshrc.tmux ]]; then
    source ~/.zshrc.tmux
  fi
fi

