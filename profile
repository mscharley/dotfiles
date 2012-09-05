
# History controls
export HISTFILE=$HOME/.zhistory
export HISTSIZE=1000
export SAVEHIST=1000

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
export LC_COLLATE=C
export LC_CTYPE=C

# Setup paths
export GEM_HOME=$HOME/rubygems
export PATH=$HOME/bin:$HOME/.bin:$PATH:$GEM_HOME/bin

