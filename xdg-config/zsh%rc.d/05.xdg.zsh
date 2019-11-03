#!/usr/bin/env zsh

# Configure XDG defaults are configured in ~/.profile

# Backport XDG into applications that can support it implicitly through configuration.

if [[ -d $HOME/Library/Android/sdk ]]; then
  ANDROID_HOME="$HOME/Library/Android/sdk"
else
  ANDROID_HOME="${XDG_CONFIG_HOME:-$HOME/opt}/android"
fi

CARGO_HOME="${XDG_DATA_HOME}/cargo"
DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
ELINKS_CONFDIR="${XDG_CONFIG_HOME}/elinks"
ICEAUTHORITY="${XDG_CACHE_HOME}/ICEauthority"
RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"
alias tmux='tmux -f "${XDG_CONFIG_HOME}/tmux/tmux.conf"'

NODE_REPL_HISTORY="${XDG_DATA_HOME}/node/repl_history"
NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
NVM_HOME="${NVM_DIR:-${XDG_DATA_HOME}/nvm}"
NVM_DIR="${NVM_DIR:-${XDG_CACHE_HOME}/nvm}"

if [[ -n "$XDG_RUNTIME_DIR" ]]; then
  TMUX_TMPDIR="$XDG_RUNTIME_DIR"
  XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
fi

# Exporting VIMINIT interferes with other similar applications such as neovim. However, for $EDITOR=vim to work it is
# necessary.
if [[ $EDITOR == "vim" ]]; then
  if command -v nvim &> /dev/null; then
    function nvim {
      VIMINIT= command nvim "$@"
    }
  fi

  export VIMINIT=":source ${XDG_CONFIG_HOME}/vim/vimrc"
else
  function vim {
    VIMINIT=":source ${XDG_CONFIG_HOME}/vim/vimrc" command vim "$@"
  }
fi
