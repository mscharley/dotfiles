{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  vim.diagnostics.nvim-lint = {
    linters.eslint_d = {
      args = [
        "--format"
        "json"
        "--fix"
      ];
      stdin = false;
      parser = mkLuaInline /* lua */ ''
        function(output, bufnr, linter_cwd)
          if string.find(output, "Error: Could not find config file") then
            return {}
          end
          local result = require("lint.linters.eslint").parser(output, bufnr)
          for _, d in ipairs(result) do
            d.source = binary_name
          end
          return vim.tbl_filter(function(d)
            local code = tostring(d.code or "")
            return not (code:match("^@stylistic/") or code == "prettier/prettier")
          end, result)
        end
      '';
    };
  };
}
