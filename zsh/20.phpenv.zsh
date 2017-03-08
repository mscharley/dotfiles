#!/usr/bin/env zsh

if [[ (! -d $HOME/.phpenv) ]]; then
  alias get-phpenv="git clone git://github.com/phpenv/phpenv.git ~/.phpenv; echo You will need to reload your shell now."
else
  prepend-path "$HOME/.phpenv/bin"
  prepend-path "$HOME/.phpenv/shims"
  source "$HOME/.phpenv/completions/phpenv.zsh"
fi
