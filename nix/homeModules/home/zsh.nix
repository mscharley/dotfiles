{
  config,
  lib,
  pkgs,
  ...
}:
# Zsh is opt-in: everything is configured here, but nothing happens until the consumer sets
# `programs.zsh.enable = true`. home-manager gates all of programs.zsh on that flag.
let
  common = import ./shell-common.nix { inherit config lib pkgs; };
  configs = "${../../../configs}/xdg/config";
  rc = name: builtins.readFile "${configs}/zsh%rc.d/${name}";
  dotDir = "${config.xdg.configHome}/zsh";
in
{
  programs.zsh = {
    inherit dotDir;
    defaultKeymap = "emacs";

    history = {
      path = "${config.xdg.dataHome}/zsh/history";
      size = 1000;
      save = 10000;
    };

    enableCompletion = true;
    completionInit = ''
      autoload -Uz compinit
      mkdir -p ${config.xdg.cacheHome}/zsh
      compinit -d ${config.xdg.cacheHome}/zsh/zcompdump-$ZSH_VERSION
    '';

    shellAliases = {
      mem = "free -m";
      please = "sudo $(fc -ln -1)";
      sum = "awk '{ s += $1; } END { print s }'";
      show-cursor = ''echo "\x1B[?25h"'';
      strip-ansi = ''sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|KG]//g"'';
      wd = "cd $(git workdir || echo .)";
    };

    initContent = lib.mkMerge [
      (lib.mkBefore (rc "00.start-profiling.zsh"))

      (lib.mkOrder 600 ''
        ${common.posixRuntime}

        # ZSH modules.
        zmodload zsh/mathfunc
        autoload colors zsh/terminfo
        autoload -U add-zsh-hook

        # Load color constants
        if [[ "$terminfo[colors]" -ge 8 ]]; then
          colors
        fi

        # Function paths.
        fpath=( ${dotDir}/functions "''${fpath[@]}" )
        autoload -Uz $(for f in ${dotDir}/functions/*; do echo ''${f##*/}; done)
      '')

      (lib.mkOrder 700 ''
        ${rc "10.keys.zsh"}
        ${rc "10.prompt.zsh"}
        ${rc "10.shopt.zsh"}
        ${rc "15.virtualenv.zsh"}
      '')

      (lib.mkOrder 800 ''
        if command -v ack &> /dev/null; then
          alias nack="ack -v"
        fi

        if command -v docker &> /dev/null; then
          alias drun="docker run -it --rm"
          alias docker-cleanup-images="docker images | grep '<none>' | awk '{ print \$3 }' | xargs docker rmi"
          alias docker-cleanup-volumes="docker volume prune -f"
          function docker-digest {
            docker image inspect "''${1:?You need to provide an image id or tag to look up.}" | jq -rM '.[].RepoDigests[0],.[].Id | strings'
          }
          function docker-cleanup {
            docker-cleanup-images
            docker-cleanup-volumes
          }
          alias dc="docker compose"
          alias dce="docker compose exec"
          alias dcep='docker compose exec $(basename "$(git workdir)")'
          function dce-bash() {
            docker compose exec "''${1:?You need to provide a service to run bash in.}" bash -l
          }
        fi

        # Open web addresses in the browser if one was set
        if [[ -n $BROWSER ]]; then
          alias -s html=$BROWSER
          alias -s org=$BROWSER
          alias -s com=$BROWSER
          alias -s net=$BROWSER
        fi

        if [[ -d ~/.var/app/com.visualstudio.code/ ]]; then
          alias code="flatpak run com.visualstudio.code"
        fi
      '')

      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (
        lib.mkOrder 850 ''
          function clear-quarantine {
            for attr in com.apple.metadata:kMDItemWhereFroms com.apple.metadata:kMDItemDownloadedDate com.apple.quarantine; do
              find "$1" -xattrname "$attr" -exec xattr -d "$attr" \{\} \;
            done
          }

          function ram-disk {
            local BLOCKS=$(( ''${1:?You must provide a size in MiB.} * 2048 ))
            diskutil erasevolume HFS+ "''${2:-Ram Disk}" `hdiutil attach -nomount ram://''${BLOCKS}`
          }

          function parallels-background-service {
            prlctl set "''${1:?You must specify a VM to update.}" --on-window-close keep-running
          }
        ''
      ))

      (lib.mkOrder 1200 ''
        zstyle ':completion:*' menu select
        zstyle ':completion:*' special-dirs true
        zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}

        setopt completealiases
      '')

      (lib.mkOrder 1400 ''
        ${rc "95.motd.zsh"}
        ${rc "96.fortune.zsh"}
      '')

      (lib.mkAfter (rc "99.end-profiling.zsh"))
    ];
  };

  # Shared with install.pl rather than copied. home-manager doesn't write this path itself.
  home.file = lib.mkIf config.programs.zsh.enable {
    "${dotDir}/functions".source = "${configs}/zsh%functions";
  };
}
