{ lib, pkgs, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  imports = [
    ./completion.nix
    ./dap.nix
    ./fzf-lua.nix
    ./lsp.nix
    ./ui.nix
    ./utility.nix
  ];

  vim = {
    # Disable default aliases until we have a valid configuration worth using
    viAlias = false;
    vimAlias = false;

    withNodeJs = true;
    extraPackages = with pkgs; [
      # Other helper utilities used by plugins
      ack
      bat
      fd
      fzf
      ripgrep
    ];

    additionalRuntimePaths = [ ./runtime ];
    startPlugins = [ "plenary-nvim" ];

    globals = {
      # Setup leader
      mapleader = " ";
      maplocalleader = "\\";
    };
    clipboard.enable = true;
    clipboard.providers.wl-copy.enable = true;

    options = {
      # Enable mouse support
      mouse = "a";

      # Styling
      cursorline = true;
      textwidth = 120;
      wrapmargin = 0;
      colorcolumn = "121";
      number = true;
      relativenumber = true;
      numberwidth = 4;
      termguicolors = true;
      scrolloff = 5;
      showtabline = 2; # 2 = always

      # Folding options
      foldmethod = "marker";

      # Tab/whitespace configuration
      list = true;

      # Backups
      backup = true;
      backupdir = mkLuaInline "vim.env.XDG_STATE_HOME .. '/nvim/backup'";

      # Allow project-specific settings
      exrc = true;
      modelines = 20;

      # Title
      title = true;
      titlestring = "%{luaeval('require(\"title\").generate()')}";
    };
    spellcheck = {
      enable = true;
      languages = [
        "en"
        "cjk"
      ];
      programmingWordlist.enable = true;
    };
    luaConfigPost = "require('whitespace').hardtabs(4)";

    binds.whichKey.enable = true;
    git.enable = true;
  };
}
