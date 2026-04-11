{ pkgs, lib, ... }:
let
  inherit (lib.nvim.dag) entryAfter;
in
{
  vim = {
    extraPackages = with pkgs; [
      # LSP packages
      vscode-js-debug
    ];

    debugger.nvim-dap = {
      enable = true;
      ui = {
        enable = true;
        # We'll set up our own hooks for this below
        autoStart = false;

        setupOpts = {
          layouts = [
            {
              # Not sure why but these need to specified in the reverse order to how dap.lua had them
              # ordered.
              elements = [
                {
                  id = "repl";
                  size = 0.1;
                }
                {
                  id = "watches";
                  size = 0.25;
                }
                {
                  id = "stacks";
                  size = 0.25;
                }
                {
                  id = "breakpoints";
                  size = 0.2;
                }
                {
                  id = "scopes";
                  size = 0.2;
                }
              ];
              position = "left";
              size = 40;
            }
            {
              elements = [
                {
                  id = "console";
                  size = 1.0;
                }
              ];
              position = "bottom";
              size = 20;
            }
          ];
        };
      };

      sources = {
        pwa-node = /* lua */ ''
          dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "''${port}",
            executable = {
              command = "${pkgs.vscode-js-debug.out}/bin/js-debug",
              args = {"''${port}"},
            }
          }
        '';
      };

      mappings = {
        continue = "<F5>";
        goDown = null;
        goUp = null;
        hover = "<leader>dh";
        restart = null;
        runLast = null;
        runToCursor = null;
        stepBack = null;
        stepOver = "<F10>";
        stepInto = "<F11>";
        stepOut = "<F12>";
        terminate = null;
        toggleBreakpoint = "<leader>db";
        toggleDapUI = null;
        toggleRepl = null;
      };
    };

    pluginRC.nvim-dap-ui = entryAfter [ "nvim-dap" ] /* lua */ ''
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   require("dapui").close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   require("dapui").close()
      -- end
    '';

    keymaps = [
      {
        desc = "Open the debugging UI";
        mode = "n";
        key = "<leader>do";
        lua = true;
        action = /* lua */ "function() require('dapui').open() end";
      }
      {
        desc = "Close the debugging UI";
        mode = "n";
        key = "<leader>dq";
        lua = true;
        action = /* lua */ "function() require('dapui').close() end";
      }
      {
        desc = "Preview";
        mode = [
          "n"
          "v"
        ];
        key = "<leader>dp";
        lua = true;
        action = /* lua */ "function() require('dap.ui.widgets').preview() end";
      }
    ];
  };
}
