{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    git
    gh
    tmux
    fastfetch
    stow
		starship
		ffmpeg
		zig
  ];

	programs.fish.enable = true;
}
