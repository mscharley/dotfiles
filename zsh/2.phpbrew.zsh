#!/usr/bin/env zsh

if [[ (! -d $HOME/.phpbrew) ]]; then
  alias get-phpbrew="curl -L -o ~/bin/phpbrew https://github.com/phpbrew/phpbrew/raw/master/phpbrew; chmod a+x ~/bin/phpbrew; phpbrew init &> /dev/null; echo You will need to reload your shell now."
else
  source "$HOME/.phpbrew/bashrc"
fi
