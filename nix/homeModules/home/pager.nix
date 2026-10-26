{ lib, pkgs, ... }:
{
  options.dotfiles.pager = lib.mkOption {
    type = lib.types.package;
    default = pkgs.most;
    defaultText = lib.literalExpression "pkgs.most";
    description = "Pager used for `$PAGER` and by delta. Installed into the user profile.";
  };
}
