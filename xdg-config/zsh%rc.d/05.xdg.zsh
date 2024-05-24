#!/usr/bin/env zsh

# XDG defaults are configured in ~/.profile - ensure they were definitely set since a user may remove source
# line for ~/.profile from their zshenv and not include new values.

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Backport XDG into applications that can support it implicitly through configuration.

if [[ -d $HOME/Library/Android/sdk ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
elif [[ -d $HOME/Android/Sdk ]]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
else
  export ANDROID_HOME="${ANDROID_HOME:-${XDG_CONFIG_HOME:-$HOME/opt}/android}"
fi

export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export ELINKS_CONFDIR="${XDG_CONFIG_HOME}/elinks"
export ICEAUTHORITY="${XDG_CACHE_HOME}/ICEauthority"
export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"

####
# Node
##
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node/repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

####
# Perl
##
append-path "$XDG_DATA_HOME/perl5/bin"

export PERL5LIB="$XDG_DATA_HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$XDG_DATA_HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$XDG_DATA_HOME/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$XDG_DATA_HOME/perl5"

####
# Rust
##
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# XDG Runtime support - must be made available by the OS but use it if provided.
if [[ -n "$XDG_RUNTIME_DIR" ]]; then
  export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
  if [[ -z $XAUTHORITY ]]; then
    export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
  fi
fi

# Vim needs a special $VIMINIT option set, but due to complexity with neovim and other forks this is offloaded to a
# script in $XDG_BIN_HOME.
