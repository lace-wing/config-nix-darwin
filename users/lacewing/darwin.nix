{
  inputs,
  pkgs,
  ...
}: {
  system.defaults = {
    universalaccess = {
      reduceMotion = true;
    };

    NSGlobalDomain = {
      # Auto-hide menu bar
      _HIHideMenuBar = true;
      # Natural scrolling
      "com.apple.swipescrolldirection" = false;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.startup.chime = false;

  system.primaryUser = "lacewing";

  users.users.lacewing = {
    home = "/Users/lacewing";
    shell = pkgs.zsh;
  };
}
