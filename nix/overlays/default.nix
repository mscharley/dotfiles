inputs: final: _: {
  dotfiles = {
    git-extensions = final.callPackage ../packages/git-extensions { };
    neovim =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = final;
        extraSpecialArgs = {
          pkg-inputs = inputs;
        };
        modules = [ ../packages/neovim ];
      }).neovim;
  };
}
