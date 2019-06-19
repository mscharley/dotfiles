#!/usr/bin/env zsh

if [[ -e ~/.nix-profile ]]; then
  source ~/.nix-profile/etc/profile.d/nix.sh
else
  function get-nix {
    NIX_INSTALLER_NO_MODIFY_PROFILE=true bash <(curl https://nixos.org/nix/install)
    source ~/.nix-profile/etc/profile.d/nix.sh
  }
fi
