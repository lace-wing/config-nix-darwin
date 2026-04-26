{
  description = "A Nix config for macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-old = {
      url = "github:NixOs/nixpkgs/4dadbbb8976a6f291c250f6546b55c2651238c2a";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # https://github.com/zhaofengli/nix-homebrew/issues/132
    nix-homebrew.url = "github:Azd325/nix-homebrew";
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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-old,
    ...
  }: let
    lib = nixpkgs.lib;

    mkSystem = import ./lib/mkSystem.nix {
      inherit nixpkgs overlays inputs;
    };

    overlays = with inputs; [
      (final: prev: {
        zjstatus = zjstatus.packages.${prev.pkgs.stdenv.hostPlatform.system}.default;
        direnv =
          # https://github.com/yu-sz/dotfiles/commit/c18062a2547b82a5e4ba5ede76c048c38fb2afff
          assert lib.assertMsg (prev.direnv.version == "2.37.1" && (prev.direnv.doCheck or true))
          "Overlay nix/overlays/direnv.nix may no longer be needed: direnv=${prev.direnv.version}, doCheck=${
            lib.boolToString (prev.direnv.doCheck or true)
          }. Try removing the overlay.";
            prev.direnv.overrideAttrs (_: {
              doCheck = false;
            });
      })
    ];
  in {
    darwinConfigurations.mbp-m1 = mkSystem "mbp-m1" {
      system = "aarch64-darwin";
      user = "lacewing";
      darwin = true;
    };

    nixosConfigurations.tp-t14 = mkSystem "tp-t14" {
      system = "x86_64-linux";
      user = "lacewing";
    };
  };
}
