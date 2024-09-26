# If we have saved XDG configuration settings, then load them
if test -e ~/.xdg
	source ~/.xdg
end

set -q XDG_CONFIG_HOME || set XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME || set XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_BIN_HOME || set XDG_BIN_HOME "$HOME/.local/bin"
set -q XDG_DATA_HOME || set XDG_DATA_HOME "$HOME/.local/share"
export XDG_CONFIG_HOME
export XDG_CACHE_HOME
export XDG_BIN_HOME
export XDG_DATA_HOME

export PATH="$XDG_BIN_HOME:$PATH"

# Backport XDG into applications that can support it implicitly through configuration.

if test -d $HOME/Library/Android/sdk; then
	export ANDROID_HOME="$HOME/Library/Android/sdk"
else if test -d $HOME/Android/Sdk; then
	export ANDROID_HOME="$HOME/Android/Sdk"
else
	set -q ANDROID_HOME || set ANDROID_HOME "$XDG_CONFIG_HOME/android"
	export ANDROID_HOME
end

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"

####
# Node
##
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

####
# Perl
##
export PATH="$PATH:$XDG_DATA_HOME/perl5/bin"

# export PERL5LIB="$XDG_DATA_HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
# export PERL_LOCAL_LIB_ROOT="$XDG_DATA_HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$XDG_DATA_HOME/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$XDG_DATA_HOME/perl5"

####
# Rust
##
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# XDG Runtime support - must be made available by the OS but use it if provided.
if test -n "$XDG_RUNTIME_DIR"
	export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
	if test -z $XAUTHORITY
		export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
	end
end

# Vim needs a special $VIMINIT option set, but due to complexity with neovim and other forks this is offloaded to a
# script in $XDG_BIN_HOME.
