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

        aptos-font = prev.pkgs.stdenvNoCC.mkDerivation {
          pname = "aptos-font";
          version = "4.4.0";
          src = prev.pkgs.fetchzip {
            url = "https://download.microsoft.com/download/8/6/0/860a94fa-7feb-44ef-ac79-c072d9113d69/Microsoft%20Aptos%20Fonts.zip";
            name = "microsoft-aptos-fonts.zip";
            sha256 = "sha256-jkYOP5upe+zMnuQtDLCAcaG1ocbx1iHm1ygW9pqGTig=";
            stripRoot = false;
          };
          installPhase = ''
            mkdir -p $out/share/fonts/truetype
            find . -name "*.ttf" -exec cp {} $out/share/fonts/truetype/ \;
          '';
        };
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
