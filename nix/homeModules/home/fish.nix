{
  config,
  lib,
  pkgs,
  ...
}:
let
  functions = "${../../../configs}/xdg/config/fish%functions";
  standalone = [
    "changeset"
    "ecr-login"
    "fish_prompt"
    "reset"
    "turbo"
  ];
in
{
  programs.fish = {
    enable = lib.mkDefault true;

    # Environment lives in home.sessionVariables (shell.nix); these are the decisions that can only be made when
    # the shell starts.
    shellInit = ''
      if test -d $HOME/Library/Android/sdk
        set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
      else if test -d $HOME/Android/Sdk
        set -gx ANDROID_HOME "$HOME/Android/Sdk"
      else
        set -q ANDROID_HOME || set ANDROID_HOME "$XDG_CONFIG_HOME/android"
        set -gx ANDROID_HOME $ANDROID_HOME
      end

      # XDG Runtime support - must be made available by the OS but use it if provided.
      if test -n "$XDG_RUNTIME_DIR"
        set -gx TMUX_TMPDIR "$XDG_RUNTIME_DIR"
        if test -z "$XAUTHORITY"
          set -gx XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
        end
      end

      if test -f /var/mail/$USER
        set -gx MAILPATH /var/mail/$USER
      end

      if test -d /home/linuxbrew/.linuxbrew
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      else if test -d /opt/homebrew
        eval "$(/opt/homebrew/bin/brew shellenv)"
      end
    '';

    interactiveShellInit = ''
      # Set tab-stops automatically if able
      if type tabs &> /dev/null
        tabs -4
      end

      if type podman &> /dev/null
        abbr --add docker podman
        abbr --add dc 'podman compose'
      else
        abbr --add dc 'docker compose'
      end

      if type direnv &> /dev/null
        direnv hook fish | source
      end

      if test -e $CODE_HOME/mscharley/nixos
        # Last modified more than one week ago (in seconds)
        if test (path mtime --relative $CODE_HOME/mscharley/nixos/flake.lock) -ge 604800
          echo (set_color --bold brred)"Updates for NixOS available."(set_color reset)
          echo
        end
      end
    '';

    shellAbbrs = {
      # asdf shims hide the real path to where corepack installs the binaries.
      yarn = "corepack yarn";
      yarnpkg = "corepack yarnpkg";
      pnpm = "corepack pnpm";
      pnpx = "corepack pnpx";
      npm = "corepack npm";
      npx = "corepack npx";

      ssm-session = "aws ssm start-session --document-name SSM-SessionManagerRunShell";
    };

    functions = {
      starship_transient_prompt_func.body = "starship module character";
      starship_transient_rprompt_func.body = "starship module time";
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
      init-terminal.body = "";

      init-syncthing.body = ''
        function syncthing-xdg
          set -l dir_id $argv[1]
          set -l dir_name $argv[2]
          if test -e $HOME/Sync/$dir_name
            if ! test "$(builtin realpath "$HOME/$dir_name")" = "$HOME/Sync/$dir_name"
              if test -e "$HOME/$dir_name"
                echo ">>> $(set_color green)Preserving existing ~/$dir_name ~/$dir_name.bak...$(set_color reset)"
                mv "$HOME/$dir_name" "$HOME/$dir_name.bak"
              end
              echo ">>> $(set_color green)Linking $dir_name folder...$(set_color reset)"
              ln -Ts "./Sync/$dir_name" "$HOME/$dir_name"
            end
            echo ">>> $(set_color green)Updating XDG folder $dir_id...$(set_color reset)"
            xdg-user-dirs-update --set $dir_id "$HOME/Sync/$dir_name"
          end
        end

        if test -e "$HOME/Sync"
          echo ">> $(set_color green)Configuring XDG for Syncthing$(set_color reset)"
          syncthing-xdg DOCUMENTS Documents
          syncthing-xdg TEMPLATES Templates
          syncthing-xdg MUSIC Music
          syncthing-xdg PICTURES Pictures
          syncthing-xdg VIDEOS Videos
        else
          echo "$(set_color yellow)Syncthing appears to not be configured yet. Run $(set_color blue)init-syncthing$(set_color yellow) after setting up Syncthing.$(set_color reset)"
        end
      '';

      init-desktop.body = ''
        init-terminal

        function ensure-flatpak
          if ! flatpak info --user "$argv[1]" &> /dev/null
            flatpak install --user -y "$argv[1]"
          end
        end

        echo ">> $(set_color green)Configuring Flatpak...$(set_color reset)"
        flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        ensure-flatpak com.github.tchx84.Flatseal
        ensure-flatpak com.github.zocker_160.SyncThingy
        ensure-flatpak io.github.giantpinkrobots.flatsweep

        init-syncthing
      '';
    };
  };

  # Shared with install.pl rather than copied.
  xdg.configFile = lib.listToAttrs (
    map (
      name:
      lib.nameValuePair "fish/functions/${name}.fish" {
        source = "${functions}/${name}.fish";
      }
    ) standalone
  );
}
