#!/bin/zsh

function parse_git_branch() {
  BRANCH=$(command git branch -a 2> /dev/null | grep "^* " | sed -e 's/^\* //')

  if [[ -n "$BRANCH" ]]; then
    if [[ "$BRANCH" == "(no branch)" ]]; then
      BRANCH=$(command git name-rev HEAD 2> /dev/null | sed 's#HEAD \(.*\)#*\1#')
    else
      # Don't display organisation folders
      BRANCH=$(basename $BRANCH)
    fi

    WORKDIR=$(basename "$(command git workdir)")

    echo " ${PR_LIGHT_BLACK}[${PR_RED}${WORKDIR}:${BRANCH}${PR_LIGHT_BLACK}]${PR_NO_COLOR}"
  fi
}

