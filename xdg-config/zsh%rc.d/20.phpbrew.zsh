#!/usr/bin/env zsh

if [[ (! -d $HOME/.phpbrew) ]]; then
  function get-phpbrew {
    mkdir -p ~/bin
    curl -sSL -o ~/bin/phpbrew https://github.com/phpbrew/phpbrew/raw/master/phpbrew || { echo "Unable to download phpbrew successfully (requires curl)."; return 1; }
    chmod a+x ~/bin/phpbrew
    ~/bin/phpbrew init
  }
else
  function phpbrew {
    unset -f phpbrew
    source $HOME/.phpbrew/bashrc
    eval `phpbrew zsh`
    phpbrew "$@"
  }
fi
