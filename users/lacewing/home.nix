{
  isWSL,
  inputs,
  user,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  fontPackages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-serif-static
    noto-fonts-cjk-sans-static
    crimson-pro
    iosevka
    nerd-fonts.monaspace
    nerd-fonts.iosevka-term
    fira-mono
    aptos-fonts
  ];

  shFunctions = builtins.readFile ./../../mods/sh/functions.sh;
  nuFunctions = builtins.readFile ./../../mods/nu/functions.nu;

  initApp = pkgs.writeShellApplication {
    name = "init";
    text = builtins.readFile ./../../mods/init/init.sh;
  };
in {
  home.stateVersion = "26.05";

  imports = [
    ./neovim.nix
    ./starship.nix
    ./zellij.nix
  ];

  _module.args = {inherit user isDarwin isLinux isWSL;};

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  home.packages = with pkgs;
    [
      ### Lang ###
      clang-tools
      python314
      typst
      dotnet-sdk
      zig
      nodejs
      go
      cargo

      ### Lib ###
      man-pages
      man-pages-posix

      ### Tool ###
      outfieldr
      fd
      fzf
      gh
      htop
      jq
      yq
      ripgrep
      tree
      flamegraph
      clipboard-jh
      exiftool
      imagemagick
      poppler-utils
      pdfpc
      mpv
      fastfetch
      giac

      ### GUI App ###
    ]
    ++ fontPackages
    ++ [
      initApp
    ]
    ++ lib.optionals isDarwin [
      # This is automatically setup on Linux
      gettext
      macism
    ]
    ++ lib.optionals (isLinux && !isWSL) [
      clang
      valgrind
    ];

  #---------------------------------------------------------------------
  # Path
  #---------------------------------------------------------------------

  home.sessionPath = [
    "$HOME/app/bin"
  ];

  #---------------------------------------------------------------------
  # Env and config files
  #---------------------------------------------------------------------

  fonts.fontconfig = {
    enable = true;

    # packages in fontPkgs
    defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = ["Noto Sans"];
      monospace = [
        "Monaspace NFM"
        "Iosevka NFM"
      ];
    };
  };

  home.sessionVariables = with config.home.sessionVariables;
    {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";

      NIX_CONFIG_DIR = "${config.xdg.configHome}/system";
      ZSH_CONFIG_DIR = "${NIX_CONFIG_DIR}/users/${user}/zsh";

      X_SRC_DIR = "$HOME/src";
      Y_SRC_DIR = "$HOME/srcy";

      UNI_DIR = "${Y_SRC_DIR}/study";
    }
    // lib.optionals isDarwin {
      # See: https://github.com/NixOS/nixpkgs/issues/390751
      DISPLAY = "nixpkgs-390751";
    };

  xdg.configFile = {
    "ghostty/".source = ./ghostty;
    "aerospace/".source = ./aerospace;
    "skhd/".source = ./skhd;
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gpg.enable = !isDarwin;

  services.gpg-agent = {
    enable = isLinux;
    pinentry.package = pkgs.pinentry-tty;

    # Cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  programs.bash = {
    enable = true;
    shellOptions = [];
    historyControl = ["ignoredups" "ignorespace"];
  };

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./zsh/zshrc;
    profileExtra = lib.concatStringsSep "\n" [
      (builtins.readFile ./zsh/zprofile)
      shFunctions
    ];
  };

  programs.nushell = {
    enable = true;
    extraConfig = nuFunctions;
    settings = {
      show_banner = false;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      whitelist = {
        exact = ["~/.envrc"];
        prefix = [
          "~/src"
          "~/srcy"
        ];
      };
    };
  };

  programs.zoxide = {
    enable = true;
  };

  programs.carapace = {
    enable = true;
  };

  programs.git = {
    enable = true;
  };

  programs.gh = {
    enable = true;
  };

  programs.pandoc = {
    enable = true;
  };

  programs.ghostty = {
    enable = true;
    # settings = xdg files
    installVimSyntax = true;
    package =
      if isDarwin
      then pkgs.ghostty-bin # Nix does not support Swift 6 and Xcode build env yet.
      else pkgs.ghostty;
  };

  programs.sketchybar = {
    enable = isDarwin;
    config = {
      recursive = true;
      source = ./sketchybar;
    };
  };

  programs.aerospace = {
    enable = isDarwin;
    # settings = xdg.configFile
  };

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = lib.mkIf (isLinux && !isWSL) {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };

  #---------------------------------------------------------------------
  # Aliases
  #---------------------------------------------------------------------

  # UNIX and POSIX
  home.shellAliases = with config.home.sessionVariables;
    {
      l = "ls -l";
      la = "ls -a";
      ll = "ls -la";

      rc = "${EDITOR} ${NIX_CONFIG_DIR}";
      zrc = "${EDITOR} ${ZSH_CONFIG_DIR}/zshrc";

      men = "tldr";
      human = "tldr_fzf_preview";

      cd = "z";
      cdd = "cd_git_top";

      v = "${EDITOR}";
      vv = "fzf_editor";
    }
    // (
      if isDarwin
      then {
        cddc = "cd ~/Documents/";
        cddw = "cd ~/Downloads/";
        cdds = "cd ~/Desktop/";
        cdpc = "cd ~/Pictures/";
        cdss = "cd ~/Pictures/Screen\\ Shot/";
        cdas = "cd ~/Library/Application\\ Support/";
        cdic = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs";
      }
      else {}
    );
}
