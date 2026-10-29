{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./editor.nix
    ./git.nix
    ./legacy.nix
    ./pager.nix
    ./shell.nix
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];

  home.shell.enableShellIntegration = true;
  home.preferXdgDirectories = true;

  home.packages =
    with pkgs;
    [
      dotfiles.git-extensions
      # Terminal apps
      jq
      yq-go
      asdf-vm
      starship

      # Referenced by the symbol_map entries in kitty's emoji.conf
      symbola
    ]
    # macOS uses Apple Color Emoji, CoreText can't load Noto's bitmaps
    ++ lib.optional pkgs.stdenv.hostPlatform.isLinux noto-fonts-color-emoji
    ++ [
      config.dotfiles.editor
      config.dotfiles.pager
    ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
