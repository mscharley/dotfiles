#!/usr/bin/env zsh

if [[ (! -d $HOME/.rvm) && (! -d /usr/local/rvm) ]]; then
  alias get-rvm="gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \curl -sSL https://get.rvm.io | bash -s stable --ignore-dotfiles"
else
  if [[ -d $HOME/.rvm ]]; then
    alias update-rvm="rvm get stable --ignore-dotfiles"
  else
    alias update-rvm="PROMPT= RPROMPT= PS2= rvmsudo rvm get stable --ignore-dotfiles; rvm reload"
  fi
fi

# Load RVM into a shell session *as a function* if it exists
if [[ -d $HOME/.rvm ]]; then
  append-path $HOME/.rvm/bin
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi
