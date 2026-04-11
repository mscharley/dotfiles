{ ... }:
{
  imports = [
    ./filetypes.nix
    ./keybindings.nix
  ];

  vim = {
    utility.surround = {
      enable = true;
      useVendoredKeybindings = false;
    };
  };
}
