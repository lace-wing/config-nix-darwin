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

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-serif-static
      noto-fonts-cjk-sans-static
      crimson-pro
      iosevka
      nerd-fonts.monaspace
      nerd-fonts.iosevka-term
      fira-mono
      xits-math
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [
        "Monaspace NFM"
        "Iosevka NFM"
      ];
    };
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
