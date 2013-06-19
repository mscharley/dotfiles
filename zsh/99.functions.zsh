#!/bin/zsh

function parse_git_branch() {
  local BRANCH=$(command git branch -a 2> /dev/null | grep "^* " | sed -e 's/^\* //')

  if [[ -n "$BRANCH" ]]; then
    if [[ "$BRANCH" == "(no branch)" ]]; then
      BRANCH=$(command git name-rev HEAD 2> /dev/null | sed 's#HEAD \(.*\)#*\1#')
    fi

    local WORKDIR=$(basename "$(command git workdir)")

    echo " ${PR_LIGHT_BLACK}[${PR_RED}${WORKDIR}:${BRANCH}${PR_LIGHT_BLACK}]${PR_NO_COLOR}"
  fi
}

function vagrant() {
  local curr_rvm=$rvm_env_string
  rvm use system
  command vagrant "$@"
  rvm use $curr_rvm
}

