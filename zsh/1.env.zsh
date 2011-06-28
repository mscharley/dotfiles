#!/bin/zsh

# History controls
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000

# Setup environment
TZ="Australia/Sydney"
HOSTNAME="`hostname`"
PAGER="less"
EDITOR="vim"

# Language setup
LC_ALL="en_US.UTF-8"
LANG="en_US.UTF-8"
LC_CTYPE=C

# Setup paths
GEM_HOME=$HOME/rubygems
PATH=$PATH:$HOME/bin:$GEM_HOME/bin

