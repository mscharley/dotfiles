{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  vim.filetree.nvimTree = {
    enable = true;
    openOnSetup = false;
    mappings = {
      findFile = null;
      toggle = "<leader>s";
      focus = null;
      refresh = null;
    };

    setupOpts = {
      disable_netrw = true;
      git.enable = true;
      diagnostics = {
        enable = true;
        show_on_dirs = false;
        show_on_open_dirs = true;
      };
      filters = {
        git_ignored = false;
        git_clean = false;
      };
      renderer = {
        highlight_opened_files = "name";
        icons = {
          git_placement = "after";
          show.git = true;
          glyphs = {
            git = {
              # don't call out staged changes explicitly
              staged = " ";
              unstaged = "✗";
              unmerged = " ";
              renamed = " ";
              untracked = " ";
              deleted = " ";
              ignored = " ";
            };
          };
        };
        indent_markers = {
          enable = true;
          inline_arrows = true;
          icons = {
            corner = "┖";
            edge = "┃";
            item = "┠";
            bottom = "─";
            none = " ";
          };
        };
      };
      on_attach = mkLuaInline /* lua */ ''
        function(bufnr)
          local api = require('nvim-tree.api')
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- Attach all the default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- Remove unwanted mappings
          vim.keymap.del('n', '<C-]>', { buffer = bufnr })
          vim.keymap.del('n', 'g?',    { buffer = bufnr })
          vim.keymap.del('n', 's',     { buffer = bufnr })

          -- Add our own mappings
          vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))
          vim.keymap.set('n', '<Esc>', function() require('nvim-tree.api').tree.toggle() end, opts('Close'))

          -- Automatically open file on creation
          api.events.subscribe(api.events.Event.FileCreated, function(file)
            api.tree.close()
            vim.schedule(function()
              vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
            end)
          end)
        end
      '';
      view = {
        width = mkLuaInline /* lua */ ''
          function()
            return math.floor(vim.opt.columns:get() * 0.5)
          end
        '';
        float = {
          enable = true;
          open_win_config = mkLuaInline /* lua */ ''
            function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * 0.5
              local window_h = screen_h * 0.8
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

              return {
                border = 'rounded',
                relative = 'editor',
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end
          '';
        };
      };
    };
  };

  vim.lazy.plugins.nvim-tree-lua.beforeSetup = /* lua */ ''
    local original_setup = require('nvim-tree').setup
    require('nvim-tree').setup = function(opts)
      opts = opts or {}
      opts.filters = opts.filters or {}
      opts.filters.custom = { "^\\.git$", "^\\.turbo$", "^\\.direnv$", "^node_modules$" }
      original_setup(opts)
    end
  '';
}
