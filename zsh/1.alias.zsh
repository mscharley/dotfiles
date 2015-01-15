#!/bin/zsh

# Directory listings
alias ls="ls --color=auto -F"
alias ll="ls -lah"
alias la="ls -A"

alias mem="free -m"

alias sass="sass -t expanded --no-cache --unix-newlines -l --debug-info -E utf-8"
alias sassw="sass --watch sass:css"
alias touchsass="find ./ -iname \"*.scss\" -exec touch \{\} \;"

alias php-xdebug="php -dxdebug.remote_autostart=On"

alias please='sudo $(fc -ln -1)'

alias sum="awk '{ s += \$1; } END { print s}'"
