#!/bin/zsh

# Load color constants
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
PR_NO_COLOR="%{$terminfo[sgr0]%}"
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE BLACK; do
  eval PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_$color='%{${PR_NO_COLOR}$terminfo[normal]$fg[${(L)color}]%}'
done

# Enable substitutions in the prompt
setopt PROMPT_SUBST

# See if we can use extended characters to look nicer.
typeset -A altchar
set -A altchar ${(s..)terminfo[acsc]}
PR_SET_CHARSET="%{$terminfo[enacs]%}"
PR_SHIFT_IN="%{$terminfo[smacs]%}"
PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
PR_HBAR=${altchar[q]:--}
PR_ULCORNER=${altchar[l]:--}
PR_LLCORNER=${altchar[m]:--}
PR_LRCORNER=${altchar[j]:--}
PR_URCORNER=${altchar[k]:--}

# Setup some variables for use in the actual prompt
precmd() {
  if [[ -n "$TMUX" ]]; then
    PR_USER="%n:%l"
  else
    PR_USER="%n@%m:%l"
  fi

  local bare_prompt=${(%):-(${PR_USER})-- }

  unset PR_RUBY
  if [[ -n "$rvm_version" ]]; then
    local rvm_color="$PR_GREEN"
    local rvm_version=`rvm current`
    if [[ "$rvm_version" == "system" ]]; then
      rvm_color="${PR_RED}"
    fi
    bare_prompt="${bare_prompt}-[${rvm_version}]"
    PR_RUBY="${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_HBAR}${PR_SHIFT_OUT}[${rvm_color}${rvm_version}${PR_LIGHT_BLACK}]${PR_NO_COLOR}"
  fi

  PR_GIT=`parse_git_branch`
  if [[ -n "$PR_GIT" ]]; then
    bare_prompt="${bare_prompt}-[${PR_GIT}]"
    PR_GIT="${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_HBAR}${PR_SHIFT_OUT}[${PR_GREEN}${PR_GIT}${PR_LIGHT_BLACK}]${PR_NO_COLOR}"
  fi

  local TERMWIDTH
  (( TERMWIDTH = ${COLUMNS} - 1 ))
  local promptsize=${#${bare_prompt}}
  PR_FILLBAR="\${(l.(($TERMWIDTH - $promptsize))..${PR_HBAR}.)}"

  if [[ "$USER" == "root" ]]; then
    PR_USER_COLOR="${PR_RED}"
  else
    PR_USER_COLOR="${PR_LIGHT_MAGENTA}"
  fi
}

# Actual prompt variables
PROMPT='${PR_SET_CHARSET}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_ULCORNER}${PR_SHIFT_OUT}[${PR_USER_COLOR}${PR_USER}${PR_LIGHT_BLACK}]${PR_RUBY}${PR_GIT}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_HBAR}${PR_URCORNER}${PR_SHIFT_OUT}
${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}[${PR_GREEN}%3c${PR_LIGHT_BLACK}]${PR_NO_COLOR}%(!.#.\$) '
RPROMPT='${PR_LIGHT_BLACK}[%?]${PR_SHIFT_IN}${PR_LRCORNER}${PR_SHIFT_OUT}${PR_NO_COLOR}'
PS2='${PR_LIGHT_BLACK}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}[${PR_GREEN}%_${PR_LIGHT_BLACK}]${PR_NO_COLOR}> '
PS4='[${LINENO}]+'
