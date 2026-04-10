{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  vim.autocomplete.nvim-cmp = {
    enable = true;
    mappings.scrollDocsUp = "<C-b>";
    setupOpts.mapping = {
      "<Up>" = mkLuaInline "cmp.mapping.select_prev_item()";
      "<Down>" = mkLuaInline "cmp.mapping.select_next_item()";
    };
  };

  vim.snippets.luasnip = {
    enable = true;
    # Extend filetype associations so JSX/TSX files get JS/TS snippets
    loaders = ''
      require('luasnip').filetype_extend("javascriptreact", {"javascript"})
      require('luasnip').filetype_extend("typescriptreact", {"typescript"})
    '';
  };
}
