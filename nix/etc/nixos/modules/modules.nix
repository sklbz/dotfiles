{ pkgs, ... }:

{
  imports = [
		./gpu.nix
    ./packages.nix
		./users.nix
		./network.nix
  ];

	nixpkgs.config.allowUnfree = true;
}
