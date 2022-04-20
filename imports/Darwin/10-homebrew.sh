#!/usr/bin/env bash

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew tap homebrew/bundle
brew bundle --file=imports/Darwin/Brewfile --no-upgrade
defaults write org.gpgtools.pinentry-mac UseKeychain -bool NO
