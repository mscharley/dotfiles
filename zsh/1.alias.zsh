#!/bin/zsh

# Directory listings
alias ls="ls --color=auto -F"
alias ll="ls -lah"
alias la="ls -A"

alias mem="free -m"

alias php-xdebug="php -dxdebug.remote_autostart=On"

alias please='sudo $(fc -ln -1)'

alias sum="awk '{ s += \$1; } END { print s}'"
