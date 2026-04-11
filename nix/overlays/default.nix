inputs: final: _: {
  dotfiles = {
    git-extensions = final.callPackage ../packages/git-extensions {
      rev = inputs.self.shortRev or inputs.self.dirtyShortRev or "unknown";
    };
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
