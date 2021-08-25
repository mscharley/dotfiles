#!/usr/bin/env zsh

# XDG defaults are configured in ~/.profile - ensure they were definitely set since a user may remove source
# line for ~/.profile from their zshenv and not include new values.

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Backport XDG into applications that can support it implicitly through configuration.

if [[ -d $HOME/Library/Android/sdk ]]; then
  ANDROID_HOME="$HOME/Library/Android/sdk"
else
  ANDROID_HOME="${XDG_CONFIG_HOME:-$HOME/opt}/android"
fi

DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
ELINKS_CONFDIR="${XDG_CONFIG_HOME}/elinks"
ICEAUTHORITY="${XDG_CACHE_HOME}/ICEauthority"
SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"

####
# Node
##
NODE_REPL_HISTORY="${XDG_DATA_HOME}/node/repl_history"
NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
NVM_HOME="${NVM_DIR:-${XDG_DATA_HOME}/nvm}"
NVM_DIR="${NVM_DIR:-${XDG_CACHE_HOME}/nvm}"

####
# Perl
##
append-path "$XDG_DATA_HOME/perl5/bin"

PERL5LIB="$XDG_DATA_HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
PERL_LOCAL_LIB_ROOT="$XDG_DATA_HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
PERL_MB_OPT="--install_base \"$XDG_DATA_HOME/perl5\""
PERL_MM_OPT="INSTALL_BASE=$XDG_DATA_HOME/perl5"

####
# Rust
##
CARGO_HOME="${XDG_DATA_HOME}/cargo"
RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# XDG Runtime support - must be made available by the OS but use it if provided.
if [[ -n "$XDG_RUNTIME_DIR" ]]; then
  TMUX_TMPDIR="$XDG_RUNTIME_DIR"
  if [[ -z $XAUTHORITY ]]; then
    XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
  fi
fi

# Vim needs a special $VIMINIT option set, but due to complexity with neovim and other forks this is offloaded to a
# script in $XDG_BIN_HOME.
