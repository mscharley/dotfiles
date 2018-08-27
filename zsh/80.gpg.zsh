#!/usr/bin/env zsh

function reload-gpg-agent() {
  gpg-connect-agent /bye &> /dev/null
  if [[ $? -ne 0 ]]; then
    eval $(gpg-agent --daemon)
  else
    unset SSH_AGENT_PID
    if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]]; then
      SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
  fi
}

reload-gpg-agent
# Support for curses or CLI-based pin entry applications
GPG_TTY="$(tty)"
