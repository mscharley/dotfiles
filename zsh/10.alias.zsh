#!/usr/bin/env zsh

# Directory listings
alias ls="ls --color=auto -F"
alias ll="ls -lah"
alias la="ls -A"

alias mem="free -m"

alias php-xdebug="php -dxdebug.remote_autostart=On"

alias please='sudo $(fc -ln -1)'

alias sum="awk '{ s += \$1; } END { print s }'"

if which ack &> /dev/null; then
  alias nack="ack -v"
fi

if which docker-compose &> /dev/null; then
  alias dc="docker-compose"
  alias dce="docker-compose exec"
  function dce-bash() {
    docker-compose exec "${1:?You need to provide a service to run bash in.}" bash -l
  }
fi
