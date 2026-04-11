{ ... }:
{
  vim = {
    fzf-lua = {
      enable = true;
      profile = "fzf-native";
    };

    keymaps = [
      {
        desc = "Fuzzy find files";
        key = "<leader>rg";
        mode = "n";
        lua = true;
        action = "function() require('fzf-lua').files({}) end";
      }
      {
        desc = "Search project";
        key = "<leader>rr";
        mode = "n";
        lua = true;
        action = "function() require('fzf-lua').live_grep({ resume = true }) end";
      }
      {
        desc = "Search project (clean)";
        key = "<leader>rR";
        mode = "n";
        lua = true;
        action = "function() require('fzf-lua').live_grep({ resume = false }) end";
      }
    ];
  };
}
