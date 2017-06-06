#!/usr/bin/env zsh

function reload-gpg-agent() {
  if [ -e "$HOME/.gpg-agent-info" ]; then
    source $HOME/.gpg-agent-info
    export GPG_AGENT_INFO
  fi

  gpg-connect-agent /bye &> /dev/null
  if [ $? != 0 ]; then
    eval $(gpg-agent --daemon)
  fi
}

reload-gpg-agent
# Support for curses or CLI-based pin entry applications
export GPG_TTY="$(tty)"
