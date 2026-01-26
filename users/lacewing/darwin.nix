{
  inputs,
  pkgs,
  user,
  ...
}: let
in {
  homebrew = {
    brews = [
      "skhd-zig"
    ];

    casks = [
      "lulu"
      "maccy"
      "zen"
      "zoom"
      "legcord"
      "whatsapp"
      "mumble"
      "zerotier-one"
      "zotero"
      "sf-symbols"
      "intellij-idea"
      "affinity-designer"
      "affinity-photo"
      "affinity-publisher"
      "microsoft-powerpoint"
      "microsoft-word"
      "steam"
    ];

    masApps = {
      Xcode = 497799835;
      Amphetamine = 937984704;
    };

    taps = [
      "homebrew/core"
      "homebrew/cask"
      "jackielii/tap"
      "LouisBrunner/valgrind"
    ];

    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };

    enable = true;
  };

  system.defaults = {
    universalaccess = {
      reduceMotion = true;
    };

    NSGlobalDomain = {
      ### Control ###
      # Natural scrolling
      "com.apple.swipescrolldirection" = false;
      # Spring loading on folders
      "com.apple.springing.enabled" = true;

      ### Appearance ###
      # Auto-hide menu bar
      _HIHideMenuBar = true;

      ### Trackpad ###
      # Tap to click
      "com.apple.mouse.tapBehavior" = 1;

      ### Sound ###
      # Beep when volume changed
      "com.apple.sound.beep.feedback" = 0;
      # Beep volume (1/e * e^x or 0 when x = 0)
      "com.apple.sound.beep.volume" = 0.6065307;
    };

    dock = {
      enable-spring-load-actions-on-all-items = true;
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false; # Only in State Manager
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.startup.chime = false;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-serif-static
    noto-fonts-cjk-sans-static
    crimson-pro
    iosevka
    nerd-fonts.monaspace
    nerd-fonts.iosevka-term
    xits-math
  ];

  system.primaryUser = "lacewing";

  users.users.lacewing = {
    home = "/Users/lacewing";
    shell = pkgs.zsh;
  };
}
