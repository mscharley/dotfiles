#!/usr/bin/env zsh

if [[ -e ~/.nix-profile ]]; then
  source ~/.nix-profile/etc/profile.d/nix.sh
  alias nix-gc="nix-collect-garbage --delete-older-than 14d"
else
  function get-nix {
    NIX_INSTALLER_NO_MODIFY_PROFILE=true bash <(curl https://nixos.org/nix/install)
    source ~/.nix-profile/etc/profile.d/nix.sh
  }
fi
