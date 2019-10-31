#!/usr/bin/env/zsh

if [[ -d ${CARGO_HOME:-~/.cargo}/bin ]]; then
  source ${CARGO_HOME:-~/.cargo}/env
else
  function rustup {
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
    source ${CARGO_HOME:-~/.cargo}/env
    unset -f rustup
    rustup "$@"
  }
fi
