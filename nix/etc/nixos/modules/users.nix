{ pkgs, ... }:

{
	users.users.sklbz = {
		isNormalUser = true;
		home = "/home/sklbz";
		extraGroups = ["wheel"];
		shell = pkgs.fish;
	};
}
