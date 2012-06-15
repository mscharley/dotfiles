#!/bin/zsh

function parse_git_branch() {
  local BRANCH=$(git branch -a 2> /dev/null | grep "^* " | sed -e 's/^\* //')

  if [[ -n "$BRANCH" ]]; then
    if [[ "$BRANCH" == "(no branch)" ]]; then
      BRANCH=$(git name-rev HEAD 2> /dev/null | sed 's#HEAD \(.*\)#*\1#')
    fi

    local WORKDIR=$(git workdir | xargs basename)

    echo " ${PR_LIGHT_BLACK}[${PR_NO_COLOR}${PR_RED}${WORKDIR}:${BRANCH}${PR_LIGHT_BLACK}]${PR_NO_COLOR}"
  fi
}

function chpwd() {
  SCM_BRANCH=$(parse_git_branch)
}

# Ensure this hook is called to do initial setup if needed
chpwd

