{inputs, ...}: let
  self = inputs.self;
  nix-darwin = inputs.nix-darwin;
  nix-homebrew = inputs.nix-homebrew;
  configuration = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      mkalias
      vim
    ];

    system.activationScripts.applications.text = let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = ["/Applications"];
      };
    in
      pkgs.lib.mkForce ''
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix\ Apps/$app_name"
        done
      '';

    nix.settings.experimental-features = "nix-command flakes";
    system.configurationRevision = self.rev or self.dirtyRev or null;
    system.stateVersion = 6;
    nixpkgs.hostPlatform = "aarch64-darwin";
  };
in {
  flake = {
    darwinConfigurations.default = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        /*
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "steve";
            mutableTaps = false;
            taps = with inputs; {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
            };
          };
        }
        */
      ];
    };

    darwinPackages = self.darwinConfigurations.default.pkgs;
  };
}
