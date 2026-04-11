{
  description = "Nix home-manager module and extra packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts/main";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }:
      let
        overlay = import ./nix/overlays/default.nix inputs;
      in
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager
        ];

        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];

        flake =
          { ... }:
          {
            homeModules.home = ./nix/homeModules/home;
            overlays.default = overlay;
          };

        perSystem =
          { system, ... }:
          let
            pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [ overlay ];
            };
          in
          {
            packages = pkgs.dotfiles;
          };
      }
    );
}
