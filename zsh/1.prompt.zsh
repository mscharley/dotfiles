#!/usr/bin/env zsh

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

# Setup some variables for use in the actual prompt (definition in fpath)
precmd_functions[$(($#precmd_functions+1))]='prompt_precmd'
preexec_functions[$(($#preexec_functions+1))]='prompt_preexec'
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
PROMPT='${PR_SET_CHARSET}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_ULCORNER}${PR_SHIFT_OUT}[${PR_USER_COLOR}${PR_USER}${PR_LIGHT_BLACK}]${PR_RUBY}${PR_GIT}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_SHIFT_OUT}${PR_EMAIL}${PR_SHIFT_IN}${PR_LIGHT_BLACK}${PR_URCORNER}${PR_SHIFT_OUT}
${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}[${PR_GREEN}%3c${PR_LIGHT_BLACK}]${PR_NO_COLOR}%(!.#.\$) '
RPROMPT='${PR_LIGHT_BLACK}[${PR_CYAN}%?${PR_LIGHT_BLACK}]-[${PR_CYAN}$(($SECONDS - $START_SECONDS))s${PR_RED}/${PR_CYAN}%D{%H%M}${PR_LIGHT_BLACK}]${PR_SHIFT_IN}${PR_LRCORNER}${PR_SHIFT_OUT}${PR_NO_COLOR}'
PS2='${PR_LIGHT_BLACK}${PR_LIGHT_BLACK}${PR_SHIFT_IN}${PR_LLCORNER}${PR_SHIFT_OUT}[${PR_GREEN}%_${PR_LIGHT_BLACK}]${PR_NO_COLOR}> '
PS4='[${LINENO}]+'
