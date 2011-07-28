#!/bin/zsh

# Load color constants
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE BLACK; do
  eval PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_$color='%{$fg[${(L)color}]%}'
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

#parse_git_branch() {
#  git name-rev HEAD 2> /dev/null | sed "s#HEAD \(.*\)# $PR_LIGHT_BLACK""[$PR_NO_COLOR$PR_RED\1$PR_LIGHT_BLACK]$PR_NO_COLOR#"
#}

# Enable substitutions in the prompt
setopt PROMPT_SUBST

# Actual prompt variables
PROMPT="$PR_LIGHT_BLACK"'[$PR_NO_COLOR$PR_RED%n@%m $PR_GREEN%2c$PR_LIGHT_BLACK]$(parse_git_branch)$PR_NO_COLOR%(!.#.$) '
RPROMPT="$PR_LIGHT_BLACK"'[%?]'"$PR_NO_COLOR";

