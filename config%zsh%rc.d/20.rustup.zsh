#!/usr/bin/env/zsh

if [[ -d ~/.cargo/bin ]]; then
  prepend-path ~/.cargo/bin
else
  function rustup {
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
    prepend-path ~/.cargo/bin
    unset -f rustup
    rustup "$@"
  }
fi
