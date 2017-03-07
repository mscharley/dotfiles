#!/usr/bin/env zsh

PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M:%S.%6.} %N:%i> '
    exec 3>&2 2>$HOME/tmp/startlog.$$
    setopt xtrace prompt_subst
fi

# History controls
export HISTFILE=$HOME/.zhistory
export HISTSIZE=1000
export SAVEHIST=1000

# Source .profile for environment variables
if [ -f ~/.profile ]; then
	. ~/.profile
fi
