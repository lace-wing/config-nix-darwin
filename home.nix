{inputs, ...}: let
  home-manager = inputs.home-manager;
  configuration = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      yq
    ];

    home.stateVersion = "25.05";
  };
in {
  flake = {
    homeConfigurations.steve = {pkgs, ...}:
      home-manager.lib.homeManagerConfiguration {
        modules = [configuration];
      };
  };
}
