{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
		lazygit
		yazi
    git
    gh
    tmux
    stow
		starship
		zig
  ];

	programs.fish.enable = true;
}
