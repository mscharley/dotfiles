{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  vim.autocmds = [
    # Highlight yanked text
    {
      event = [ "TextYankPost" ];
      pattern = [ "*" ];
      callback = mkLuaInline /* lua */ ''
        function()
          (vim.hl or vim.highlight).on_yank {
            timeout = 200,
          }
        end
      '';
    }

    # JSON files are actually JSON5 for comment support
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [ "*.json" ];
      command = "set filetype=json5";
    }

    # Filetype-specific settings
    {
      event = [ "FileType" ];
      pattern = [ "gitcommit" ];
      callback = mkLuaInline /* lua */ ''
        function()
          vim.opt_local.colorcolumn = "73"
          -- This hides the tabline, even if another tab is opened. This is usually ok for git commits.
          vim.opt.showtabline = 0
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = [ "gleam" ];
      callback = mkLuaInline /* lua */ ''
        function()
          -- Gleams built-in formatter insists on soft tabs
          require("whitespace").softtabs(2, true)
          vim.opt_local.colorcolumn = "81"
          vim.opt_local.commentstring = "// %s"
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = [ "help" ];
      callback = mkLuaInline /* lua */ ''
        function()
          vim.opt_local.colorcolumn = ""
          vim.opt_local.spell = false
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = [ "nix" ];
      callback = mkLuaInline /* lua */ ''
        function()
          -- Rescripts built-in formatter insists on soft tabs
          require("whitespace").softtabs(2, true)
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = [ "rescript" ];
      callback = mkLuaInline /* lua */ ''
        function()
          -- Rescripts built-in formatter insists on soft tabs
          require("whitespace").softtabs(2, true)
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = [ "rust" ];
      callback = mkLuaInline /* lua */ ''
        function()
          require('whitespace').hardtabs(4, true)
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = [ "yaml" ];
      callback = mkLuaInline /* lua */ ''
        function()
          -- YAML doesn't work with hard tabs
          require('whitespace').softtabs(2, true)
        end
      '';
    }
  ];
}
