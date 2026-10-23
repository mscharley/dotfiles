{
  config,
  lib,
  pkgs,
  ...
}:
let
  common = import ./shell-common.nix { inherit config lib pkgs; };
in
{
  programs.bash = {
    enable = lib.mkDefault true;
    # Read for every bash that loads a bashrc, which is where this has always lived.
    bashrcExtra = common.posixRuntime;
    initExtra = builtins.readFile (../../../configs + "/home/bash/prompt");
  };
}
