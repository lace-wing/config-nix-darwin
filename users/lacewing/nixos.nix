{
  inputs,
  pkgs,
  user,
  ...
}:
{
  nix.optimise.automatic = true;

  environment.etc = {
    "icas".source = ../../mods/icas;
  };

  users.users.lacewing = {
    isNormalUser = true;
    description = "Lacewing";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  programs.zsh.enable = true;

}
