#SOURCE https://github.com/mitchellh/nixos-config/blob/main/lib/mksystem.nix
# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{
  nixpkgs,
  overlays,
  inputs,
}: name: {
  system,
  user,
  darwin ? false,
  wsl ? false,
}: let
  isWSL = wsl;
  isLinux = !darwin && !isWSL;

  # The config files for this system.
  hostConfig = ../hosts/${name}.nix;
  userOSConfig =
    ../users/${user}/${
      if darwin
      then "darwin"
      else "nixos"
    }.nix;
  userHMConfig = ../users/${user}/home.nix;

  # NixOS vs nix-darwin functions
  systemFunc =
    if darwin
    then inputs.darwin.lib.darwinSystem
    else nixpkgs.lib.nixosSystem;
  home-manager =
    if darwin
    then inputs.home-manager.darwinModules
    else inputs.home-manager.nixosModules;
  nix-homebrew = inputs.nix-homebrew.darwinModules.nix-homebrew;
  homebrew-core = inputs.homebrew-core;
  homebrew-cask = inputs.homebrew-cask;
in
  systemFunc rec {
    inherit system;

    modules = [
      {
        system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
      }

      {nixpkgs.overlays = overlays;}

      {nixpkgs.config.allowUnfree = true;}

      # Bring in WSL if this is a WSL build
      (
        if isWSL
        then inputs.nixos-wsl.nixosModules.wsl
        else {}
      )

      hostConfig
      userOSConfig
      home-manager.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import userHMConfig {
          isWSL = isWSL;
          inputs = inputs;
          user = user;
        };
        home-manager.backupFileExtension = "bak";
      }

      nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
          enableRosetta = true;
          # mutableTaps = false;
          taps = {
            "homebrew/homebrew-core" = homebrew-core;
            "homebrew/homebrew-cask" = homebrew-cask;
          };

          user = user;
          autoMigrate = true;
        };
      }

      # Extra args to systemFunc
      {
        config._module.args = {
          system = system;
          systemName = name;
          user = user;
          isWSL = isWSL;
          inputs = inputs;
        };
      }
    ];
  }
