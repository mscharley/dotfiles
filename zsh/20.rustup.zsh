#!/usr/bin/env/zsh

if [[ -d ~/.cargo/bin ]]; then
  append-path ~/.cargo/bin
else
  function rustup {
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
    append-path ~/.cargo/bin
    unset -f rustup
    rustup "$@"
  }
fi
