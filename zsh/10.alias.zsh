#!/usr/bin/env zsh

# Directory listings
if which gls &> /dev/null; then
  LS="gls"
else
  LS="ls"
fi
alias ls="$LS --color=auto -F"
alias ll="ls -lah"
alias la="ls -A"
unset LS

alias mem="free -m"

alias php-xdebug="php -dxdebug.remote_autostart=On"

alias please='sudo $(fc -ln -1)'

alias sum="awk '{ s += \$1; } END { print s }'"

alias show-cursor='echo "\x1B[?25h"'

if which ack &> /dev/null; then
  alias nack="ack -v"
fi

if which docker &> /dev/null; then
  alias drun="docker run -it --rm"
  alias docker-cleanup-images="docker images | grep '<none>' | awk '{ print \$3 }' | xargs docker rmi"
  alias docker-cleanup-volumes="docker volume prune -f"
  function docker-digest {
    docker image inspect "${1:?You need to provide an image id or tag to look up.}" | jq -rM '.[].RepoDigests[0],.[].Id | strings'
  }
  function docker-cleanup {
    docker-cleanup-images
    docker-cleanup-volumes
  }
fi

if which docker-compose &> /dev/null; then
  alias dc="docker-compose"
  alias dce="docker-compose exec"
  alias dcep='docker-compose exec $(basename "$(git workdir)")'
  function dce-bash() {
    docker-compose exec "${1:?You need to provide a service to run bash in.}" bash -l
  }
fi

if which gsed &> /dev/null; then
  alias strip-ansi='gsed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|KG]//g"'
else
  alias strip-ansi='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|KG]//g"'
fi

if which git &> /dev/null; then
  alias wd='cd $(git workdir || echo .)'
fi
