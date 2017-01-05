#!/usr/bin/env zsh

VIRTUAL_ENV_DISABLE_PROMPT=1
function venv-activate {
  source ${1:-venv}/bin/activate
}
