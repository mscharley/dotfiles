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

	outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ({ ... }: {
		imports = [
			inputs.home-manager.flakeModules.home-manager
		];

		systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

		flake = { ... }: {
			homeModules.home = ./homeModules/home;
		};

		perSystem = { pkgs, ... }: {
			packages.neovim = (inputs.nvf.lib.neovimConfiguration {
				inherit pkgs;
				extraSpecialArgs = { pkg-inputs = inputs; };
				modules = [ ./packages/neovim ];
			}).neovim;
		};
	});
}
