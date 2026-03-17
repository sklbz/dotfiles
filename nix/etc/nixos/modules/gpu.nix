{ pkgs, ... }:

{
	hardware.nvidia = {
		modesetting.enable = true;
		open = false;
	};

	hardware.opengl.enable = true;

	environment.systemPackages = with pkgs; [
		cudaPackages.cudatoolkit
		linuxPackages.nvidia_x11
	];
}
