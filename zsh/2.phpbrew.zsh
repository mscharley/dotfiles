#!/usr/bin/env zsh

if [[ (! -d $HOME/.phpbrew) ]]; then
  function get-phpbrew {
    mkdir -p ~/bin
    wget -qO ~/bin/phpbrew https://github.com/phpbrew/phpbrew/raw/master/phpbrew || { echo "Unable to download phpbrew successfully (requires wget)."; return 1; }
    chmod a+x ~/bin/phpbrew
    ~/bin/phpbrew init
  }
else
  source $HOME/.phpbrew/bashrc
  eval `phpbrew zsh`
fi
