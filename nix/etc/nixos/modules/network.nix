{ config, pkgs, ... }:

{
	wsl.wslConf.network.generateResolvConf = false;
	networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

	environment.etc."resolv.conf".text = ''
		nameserver 8.8.8.8
		nameserver 1.1.1.1
	'';
}
