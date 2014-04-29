#!/bin/zsh

# Source .profile for environment variables
if [ -f ~/.profile ]; then
	. ~/.profile
fi

# Setup paths
prepend-path $HOME/bin
prepend-path $HOME/.bin

