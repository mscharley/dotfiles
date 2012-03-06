#!/bin/zsh

# History controls
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000

# Setup environment
TZ="Australia/Melbourne"
HOSTNAME="`hostname`"
PAGER="less"
EDITOR="vim"

# Language setup
LC_ALL="en_US.UTF-8"
LANG="en_US.UTF-8"
LC_CTYPE=C

# Setup paths
GEM_HOME=$HOME/rubygems
PATH=$PATH:$GEM_HOME/bin:$HOME/bin:$HOME/.bin

