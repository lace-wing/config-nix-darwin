default: switch

switch:
	sudo -i darwin-rebuild switch --flake ~/.config/nix-darwin --show-trace --verbose
