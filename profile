#/bin/sh
# Setup environment
export TZ="Australia/Melbourne"
export HOSTNAME="`hostname`"
if which most > /dev/null 2>&1; then
  export PAGER="most"
else
  export PAGER="less"
fi
export EDITOR="vim"

# Language setup
export LANG="en_US.UTF-8"

# ls colors - LSCOLORS = BSD, LS_COLORS = GNU.
# https://geoff.greer.fm/lscolors/
export CLICOLOR=1
export LSCOLORS="exgxfxdxcxDaDaCBcDEcEc"
if which dircolors > /dev/null 2>&1; then
  eval `dircolors -b ~/.dircolors`
elif which gdircolors > /dev/null 2>&1; then
  eval `gdircolors -b ~/.dircolors`
else
  export LS_COLORS="rs=0:di=34:ln=36:so=35:pi=33:ex=32:bd=1;33;40:cd=1;33;40:su=1;32;1;41:sg=32;1;43:tw=1;34;42:ow=1;34;42"
fi
