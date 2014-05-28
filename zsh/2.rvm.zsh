#!/bin/zsh

if [[ ! -d $HOME/.rvm ]]; then
  alias get-rvm="\curl -sSL https://get.rvm.io | bash -s stable --ignore-dotfiles"
else
  alias update-rvm="rvm get stable --ignore-dotfiles"
fi
