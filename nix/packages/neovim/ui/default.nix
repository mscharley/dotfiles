{ lib, pkgs, ... }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.lua) toLuaObject;
in
{
  imports = [
    ./nvim-tree.nix
    ./theme.nix
  ];

  vim = {
    dashboard.alpha = {
      enable = true;
    };
    # Hack alpha with our custom theme
    pluginRC.alpha = lib.mkForce "require('alpha').setup(require('theme.alpha').config)";

    git.gitsigns = {
      enable = true;
      setupOpts = {
        numhl = true;
      };
    };

    globals.barbar_auto_setup = false;
    extraPlugins.barbar =
      let
        setupOpts = {
          exclude_ft = [ "gitcommit" ];
          icons = {
            gitsigns = {
              added = {
                enabled = true;
                icon = "+";
              };
              changed = {
                enabled = true;
                icon = "~";
              };
              deleted = {
                enabled = true;
                icon = "-";
              };
            };
            preset = "slanted";
          };
        };
      in
      {
        package = pkgs.vimPlugins.barbar-nvim;
        setup = "require('barbar').setup(${toLuaObject setupOpts})";
      };
    extraPlugins.wrapping = {
      package = pkgs.vimPlugins.wrapping-nvim;
      setup = "require('wrapping').setup { create_keymaps = false }";
    };
    keymaps = [
      {
        desc = "Switch to soft wrapping mode";
        key = "[ow";
        mode = "n";
        lua = true;
        action = "function() require('wrapping').soft_wrap_mode() end";
      }
      {
        desc = "Switch to hard wrapping mode";
        key = "]ow";
        mode = "n";
        lua = true;
        action = "function() require('wrapping').hard_wrap_mode() end";
      }
      {
        desc = "Toggle wrapping mode";
        key = "<leader>ow";
        mode = "n";
        lua = true;
        action = "function() require('wrapping').toggle_wrap_mode() end";
      }
    ];

    session.nvim-session-manager = {
      enable = true;
      setupOpts = {
        autoload_mode = mkLuaInline "{ sm.AutoloadMode.GitSession, sm.AutoloadMode.CurrentDir } ";
        autosave_only_in_session = true;
      };
      mappings = {
        deleteSession = null;
        loadLastSession = null;
        loadSession = null;
        saveCurrentSession = null;
      };
    };

    statusline.lualine = {
      enable = true;
      setupOpts = {
        options = {
          icons_enabled = true;
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
          globalstatus = true;
          ignore_focus = [ "help" ];
        };

        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
          ];
          lualine_c = [
            "lsp_status"
            "filename"
            "diagnostics"
          ];
          lualine_x = [
            "encoding" # "require('usermod.lualine.fileformat')"
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };

        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [ "filename" ];
          lualine_x = [ "location" ];
          lualine_y = [ ];
          lualine_z = [ ];
        };
      };
    };
  };
}
