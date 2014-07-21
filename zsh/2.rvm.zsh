#!/bin/zsh

if [[ (! -d $HOME/.rvm) && (! -d /usr/local/rvm) ]]; then
  alias get-rvm="\curl -sSL https://get.rvm.io | bash -s stable --ignore-dotfiles"
else
  if [[ -d $HOME/.rvm ]]; then
    alias update-rvm="rvm get stable --ignore-dotfiles"
  else
    alias update-rvm="rvmsudo rvm get stable --ignore-dotfiles"
  fi
fi
