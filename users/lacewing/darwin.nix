{ inputs, pkgs, ... }:
{
  system.primaryUser = "lacewing";

  users.users.lacewing = {
    home = "/Users/lacewing";
    shell = pkgs.zsh;
  };
}

