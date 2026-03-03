{ ... }:
{
	imports = [
		./utility/filetypes.nix
		./utility/keybindings.nix
	];

	vim = {
		utility.surround = {
			enable = true;
			useVendoredKeybindings = false;
		};
	};
}
