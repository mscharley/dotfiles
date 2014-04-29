#!/bin/zsh

if [[ ! -d $HOME/.rvm ]]; then
  alias get-rvm="\curl -sSL https://get.rvm.io | bash -s stable --ignore-dotfiles"
fi
