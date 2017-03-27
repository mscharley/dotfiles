#!/usr/bin/env zsh

# Load color constants
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi

PR_NO_COLOR="%{$terminfo[sgr0]%}"
if [[ "$terminfo[colors]" -ge 256 ]]; then
  # https://jonasjacek.github.io/colors/
  PR_RED="%F{88}"            #870000
  PR_LIGHT_RED="%F{160}"     #D70000
  PR_GREEN="%F{28}"          #008700
  PR_LIGHT_GREEN="%F{40}"    #00D700
  PR_YELLOW="%F{142}"        #AFAF00
  PR_LIGHT_YELLOW="%F{227}"  #FFFF5F
  PR_BLUE="%F{27}"           #005fff
  PR_LIGHT_BLUE="%F{39}"     #00afff
  PR_MAGENTA="%F{92}"        #8700D7
  PR_LIGHT_MAGENTA="%F{201}" #FF00FF
  PR_CYAN="%F{39}"           #00AFFF
  PR_LIGHT_CYAN="%F{87}"     #5FFFFF
  PR_BLACK="%F{234}"         #1C1C1C
  PR_LIGHT_BLACK="%F{240}"   #585858
  PR_WHITE="%F{247}"         #9E9E9E
  PR_LIGHT_WHITE="%F{253}"   #DADADA
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
PR_USER_COLOR="${PR_MAGENTA}"
if [[ -n "$TMUX" ]]; then
  PR_USER="%n:%l"
else
  PR_USER="%n@%m:%l"
fi

# Actual prompt variables
PROMPT='${PR_SET_CHARSET}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_ULCORNER}${PR_SHIFT_OUT}[${PR_USER_COLOR}${PR_USER}${PR_LIGHT_BLACK}]${PR_RUBY}${PR_PYTHON}${PR_GIT}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_SHIFT_OUT}${PR_EMAIL}${PR_SHIFT_IN}${PR_LIGHT_BLACK}${PR_URCORNER}${PR_SHIFT_OUT}
${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}[${PR_GREEN}%3c${PR_LIGHT_BLACK}]${PR_NO_COLOR}%(!.#.\$) '
RPROMPT='${PR_LIGHT_BLACK}[${PR_CYAN}%?${PR_LIGHT_BLACK}]-[${PR_CYAN}$(($SECONDS - $START_SECONDS))s${PR_RED}/${PR_CYAN}%D{%H%M}${PR_LIGHT_BLACK}]${PR_SHIFT_IN}${PR_LRCORNER}${PR_SHIFT_OUT}${PR_NO_COLOR}'
PS2='${PR_LIGHT_BLACK}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}[${PR_GREEN}%_${PR_LIGHT_BLACK}]${PR_NO_COLOR}> '
PS4=$'%D{%M:%S.%6.} %N:%i> '
