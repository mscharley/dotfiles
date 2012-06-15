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

# Enable substitutions in the prompt
setopt PROMPT_SUBST

# Actual prompt variables
PROMPT="\${PR_LIGHT_BLACK}[\${PR_NO_COLOR}\${PR_RED}%n@%m \${PR_GREEN}%2c\${PR_LIGHT_BLACK}]\${SCM_BRANCH}\${PR_NO_COLOR}%(!.#.\$) "
RPROMPT="\${PR_LIGHT_BLACK}[%?]\${PR_NO_COLOR}"

