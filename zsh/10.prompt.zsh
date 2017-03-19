#!/usr/bin/env zsh

# Load color constants
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
PR_NO_COLOR="%{$terminfo[sgr0]%}"
if [[ "$terminfo[colors]" -ge 256 ]]; then
  PR_RED="%F{88}"
  PR_LIGHT_RED="%F{160}"
  PR_GREEN="%F{28}"
  PR_LIGHT_GREEN="%F{40}"
  PR_YELLOW="%F{142}"
  PR_LIGHT_YELLOW="%F{227}"
  PR_BLUE="%F{21}"
  PR_LIGHT_BLUE="%F{32}"
  PR_MAGENTA="%F{92}"
  PR_LIGHT_MAGENTA="%F{201}"
  PR_CYAN="%F{39}"
  PR_LIGHT_CYAN="%F{87}"
  PR_BLACK="%F{234}"
  PR_LIGHT_BLACK="%F{240}"
  PR_WHITE="%F{247}"
  PR_LIGHT_WHITE="%F{253}"
else
  for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE BLACK; do
    eval PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_$color='%{${PR_NO_COLOR}$terminfo[normal]$fg[${(L)color}]%}'
  done
fi

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

# Setup some variables for use in the actual prompt (definition in fpath)
precmd_functions=(precmd_functions 'prompt_precmd')
preexec_functions=(preexec_functions 'prompt_preexec')
prompt_preexec

# Setup some variables once-off
if [[ -n "$TMUX" ]]; then
  PR_USER="%n:%l"
  PR_USER_COLOR="${PR_LIGHT_MAGENTA}"
else
  PR_USER="%n@%m:%l"
  PR_USER_COLOR="${PR_LIGHT_YELLOW}"
fi

# Actual prompt variables
PROMPT='${PR_SET_CHARSET}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_ULCORNER}${PR_SHIFT_OUT}[${PR_USER_COLOR}${PR_USER}${PR_LIGHT_BLACK}]${PR_RUBY}${PR_PYTHON}${PR_GIT}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_SHIFT_OUT}${PR_EMAIL}${PR_SHIFT_IN}${PR_LIGHT_BLACK}${PR_URCORNER}${PR_SHIFT_OUT}
${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}[${PR_GREEN}%3c${PR_LIGHT_BLACK}]${PR_NO_COLOR}%(!.#.\$) '
RPROMPT='${PR_LIGHT_BLACK}[${PR_CYAN}%?${PR_LIGHT_BLACK}]-[${PR_CYAN}$(($SECONDS - $START_SECONDS))s${PR_RED}/${PR_CYAN}%D{%H%M}${PR_LIGHT_BLACK}]${PR_SHIFT_IN}${PR_LRCORNER}${PR_SHIFT_OUT}${PR_NO_COLOR}'
PS2='${PR_LIGHT_BLACK}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}[${PR_GREEN}%_${PR_LIGHT_BLACK}]${PR_NO_COLOR}> '
PS4=$'%D{%M:%S.%6.} %N:%i> '
