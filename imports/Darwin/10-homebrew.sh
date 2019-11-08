#!/usr/bin/env bash

if command -v brew &> /dev/null; then true
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/bundle
brew bundle --file=imports/Darwin/Brewfile --no-upgrade
