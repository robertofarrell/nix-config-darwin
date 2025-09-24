# please change 'hostname' to your hostname
deploy:
	nix build .#darwinConfigurations.Rob-OFarrell-Easy-Agile-Mac.system \
	   --extra-experimental-features 'nix-command flakes'

	sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#Rob-OFarrell-Easy-Agile-Mac
