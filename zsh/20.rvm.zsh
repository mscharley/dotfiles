#!/usr/bin/env zsh

if [[ (! -d $HOME/.rvm) && (! -d /usr/local/rvm) ]]; then
  alias get-rvm="gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \curl -sSL https://get.rvm.io | bash -s stable --ignore-dotfiles"
else
  if [[ -d $HOME/.rvm ]]; then
    alias update-rvm="rvm get stable --ignore-dotfiles"
  else
    alias update-rvm="PROMPT= RPROMPT= PS2= rvmsudo rvm get stable --ignore-dotfiles; rvm reload"
  fi
fi
