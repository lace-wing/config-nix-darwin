default: darwin

darwin:
	sudo -i darwin-rebuild switch --show-trace --verbose --flake ~/.config/nix-darwin

