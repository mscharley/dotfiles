{ lib, pkgs, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  vim = {
    extraPlugins.lush-nvim = {
      package = pkgs.vimPlugins.lush-nvim;
      setup = "require('lush')(require('theme.lush'))";
    };

    visuals.nvim-web-devicons.enable = true;

    statusline.lualine.setupOpts.options.theme = mkLuaInline "require('theme.lualine')";
  };
}
