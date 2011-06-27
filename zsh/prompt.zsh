#!/bin/zsh

# Load color constants
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_$color='%{$fg[${(L)color}]%}'
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

parse_git_branch() {
  git name-rev HEAD 2> /dev/null | sed "s#HEAD \(.*\)# [$PR_LIGHT_RED\1$PR_NO_COLOR]#"
}

# Enable substitutions in the prompt
setopt PROMPT_SUBST

# Actual prompt variables
PROMPT='[$PR_YELLOW%n@%m $PR_GREEN%2c$PR_NO_COLOR]$(parse_git_branch)$PR_NO_COLOR%(!.#.$) '

