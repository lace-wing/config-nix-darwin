{
  description = "A macOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-old = {
      url = "github:NixOs/nixpkgs/4dadbbb8976a6f291c250f6546b55c2651238c2a";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-old,
    home-manager,
    darwin,
    ...
  }: let
    mkSystem = import ./lib/mkSystem.nix {
      inherit nixpkgs overlays inputs;
    };

    overlays = [
      (final: prev: {
        # zls = nixpkgs-old.legacyPackages.${prev.stdenv.hostPlatform.system}.zls;
      })
    ];
  in {
    darwinConfigurations.mbp-m1 = mkSystem "mbp-m1" {
      system = "aarch64-darwin";
      user = "lacewing";
      darwin = true;
    };
  };
}
