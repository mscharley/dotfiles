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
LANG="en_US.UTF-8"
LC_COLLATE=C
LC_CTYPE=C

# Setup paths
GEM_HOME=$HOME/rubygems
PATH=$HOME/bin:$HOME/.bin:$PATH:$GEM_HOME/bin

