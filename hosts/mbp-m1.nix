{
  self,
  pkgs,
  config,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;

  networking.hostName = "mbp-m1";

  environment.shells = with pkgs; [bashInteractive zsh];
  environment.systemPackages = with pkgs; [
    mkalias
    vim
  ];
}
