{
  config,
  lib,
  pkgs,
}:
# Snippets that can't be decided at evaluation time (they depend on what's on the machine when the shell
# starts), shared by the POSIX-ish shells. Not a module: imported by bash.nix and zsh.nix.
{
  posixRuntime = ''
    if [ -d "$HOME/Library/Android/sdk" ]; then
      export ANDROID_HOME="$HOME/Library/Android/sdk"
    elif [ -d "$HOME/Android/Sdk" ]; then
      export ANDROID_HOME="$HOME/Android/Sdk"
    else
      export ANDROID_HOME="''${ANDROID_HOME:-${config.xdg.configHome}/android}"
    fi

    # XDG Runtime support - must be made available by the OS but use it if provided.
    if [ -n "$XDG_RUNTIME_DIR" ]; then
      export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
      export XAUTHORITY="''${XAUTHORITY:-$XDG_RUNTIME_DIR/Xauthority}"
    fi

    if [ -f "/var/mail/$USER" ]; then
      export MAILPATH="/var/mail/$USER"
    fi

    if [ -d /home/linuxbrew/.linuxbrew ]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [ -d /opt/homebrew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  '';
}
