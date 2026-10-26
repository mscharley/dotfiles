{ lib, pkgs, ... }:
{
  options.dotfiles.editor = lib.mkOption {
    type = lib.types.package;
    default = pkgs.dotfiles.neovim;
    defaultText = lib.literalExpression "pkgs.dotfiles.neovim";
    description = "Editor used for `$EDITOR` and `$GIT_EDITOR`. Installed into the user profile.";
  };
}
