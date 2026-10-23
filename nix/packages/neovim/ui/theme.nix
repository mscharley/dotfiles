{ lib, pkgs, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  vim = {
    extraPlugins.lush-nvim = {
      package = pkgs.vimPlugins.lush-nvim;
      # Lush clears existing highlights when applying, which wipes lualine's groups if it was set up first.
      # Fire ColorScheme so lualine (and friends) re-apply theirs.
      setup = ''
        require('lush')(require('theme.lush'))
        vim.api.nvim_exec_autocmds('ColorScheme', {})
      '';
    };

    visuals.nvim-web-devicons.enable = true;

    statusline.lualine.setupOpts.options.theme = mkLuaInline "require('theme.lualine')";
  };
}
