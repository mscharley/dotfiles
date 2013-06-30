#!/bin/zsh

function parse_git_branch() {
  local BRANCH=$(command git branch -a 2> /dev/null | grep "^* " | sed -e 's/^\* //')

  if [[ -n "$BRANCH" ]]; then
    if [[ "$BRANCH" == "(no branch)" ]]; then
      BRANCH=$(command git name-rev HEAD 2> /dev/null | sed 's#HEAD \(.*\)#*\1#')
    fi

    local WORKDIR=$(basename "$(command git workdir)")

    echo "${WORKDIR}:${BRANCH}"
  fi
}

