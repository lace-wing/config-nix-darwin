default: darwin

darwin:
	sudo -i darwin-rebuild switch --show-trace --verbose --flake ~/.config/nix-darwin

nixos:
	sudo nixos-rebuild switch --flake ~/.config/nixos#tp-t14

