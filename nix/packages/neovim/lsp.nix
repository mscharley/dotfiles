{ lib, pkgs, ... }:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.lua) toLuaObject;
in
{
  vim = {
    extraPlugins.schemastore = {
      package = pkgs.vimPlugins.SchemaStore-nvim;
      setup = "";
    };

    extraPlugins.spellwarn =
      let
        setupOpts = {
          enable = false;
          severity = {
            spellbad = "WARN";
            spellrare = "HINT";
            spellcap = "HINT";
            spelllocal = "HINT";
          };
        };
      in
      {
        package = pkgs.vimPlugins.spellwarn-nvim;
        setup = "require('spellwarn').setup(${toLuaObject setupOpts})";
      };
    keymaps = [
      {
        desc = "Toggle spelling warnings";
        key = "<leader>ts";
        mode = "n";
        lua = true;
        action = "function() require('spellwarn').toggle() end";
      }
    ];

    lsp = {
      enable = true;
      lspconfig.enable = true;
      formatOnSave = true;

      presets = {
        tailwindcss-language-server.enable = true;
      };

      servers."yamlls" = {
        settings.yaml = {
          schemaStore = {
            enable = false;
            url = "";
          };
          schemas = mkLuaInline "require('schemastore').yaml.schemas()";
        };
      };

      servers."jsonls" = {
        filetypes = [
          "json"
          "jsonc"
          "json5"
        ];
        settings.json = {
          schemas = mkLuaInline "require('schemastore').json.schemas()";
          validate.enable = true;
        };
      };

      mappings = {
        addWorkspaceFolder = null;
        codeAction = "<leader>ff";
        documentHighlight = null;
        format = null;
        goToDeclaration = null;
        goToDefinition = "<leader>gi";
        goToType = null;
        hover = null; # TODO
        listDocumentSymbols = null;
        listImplementations = null;
        listReferences = "<leader>gr";
        listWorkspaceFolders = null;
        listWorkspaceSymbols = null;
        nextDiagnostic = "<leader>ge";
        openDiagnosticFloat = "<leader>e";
        previousDiagnostic = null;
        removeWorkspaceFolder = null;
        renameSymbol = "<leader>fn";
        signatureHelp = null;
        toggleFormatOnSave = null;
      };
    };

    diagnostics = {
      enable = true;
      config = {
        virtual_lines = {
          severity = {
            min = mkLuaInline "vim.diagnostic.severity.WARN";
          };
          current_line = false;
        };
      };
    };

    languages = {
      enableTreesitter = true;
      enableDAP = true;

      # Enable Nix support since we're clearly a nix user...
      nix.enable = true;

      # Markup file support
      html.enable = true;
      markdown.enable = true;

      # Full language support
      gleam.enable = true;
      lua.enable = true;
      lua.lsp.lazydev.enable = true;
      ruby.enable = true;
      rust.enable = true;
      typescript.enable = true;
      typescript.extraDiagnostics = {
        enable = true;
        types = [ "eslint_d" ];
      };

      # Shell script support
      bash.enable = true;

      # Data format support
      yaml.enable = true;
      json.enable = true;
    };

    # Prefer using the enable option under languages if there is one available
    treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      yaml
      json
      json5
      toml
      fish
      vim
      vimdoc
      graphql
      css
      diff

      rescript
      perl
    ];
  };
}
