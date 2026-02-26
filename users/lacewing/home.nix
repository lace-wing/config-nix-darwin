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

  shScripts = builtins.readFile ./../../mods/sh/scripts.sh;
  initApp = pkgs.writeShellApplication {
    name = "init";
    text = builtins.readFile ./../../mods/init/init.sh;
  };
in {
  home.stateVersion = "25.11";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  home.packages = with pkgs;
    [
      ### Lang ###
      nixd
      alejandra
      clang-tools
      lua-language-server
      python314
      pyright
      typst
      tinymist
      dotnet-sdk
      roslyn-ls
      fsautocomplete
      zig
      zls
      nodejs
      go
      harper
      ## hm ##
      # nu # ls included

      ### Lib ###

      ### Tool ###
      fd
      fzf
      gh
      htop
      jq
      ripgrep
      tree
      flamegraph
      clipboard-jh
      exiftool
      imagemagick
      poppler-utils
      giac
      ## hm ##
      # sketchybar
      # aerospace
      # zoxide
      # carapace
      # git
      # gh
      # nvim
      # bash
      # zsh
      # direnv
      # gpg
      # pandoc

      ### GUI App ###
      ## hm ##
      # ghostty
      ## brew ##
      # calibre
    ]
    ++ [
      initApp
    ]
    ++ (lib.optionals isDarwin [
      # This is automatically setup on Linux
      pkgs.gettext
      macism
    ])
    ++ (lib.optionals (isLinux && !isWSL) [
      pkgs.clang
      pkgs.valgrind
    ]);

  #---------------------------------------------------------------------
  # Path
  #---------------------------------------------------------------------

  home.sessionPath = [
    "$HOME/app/bin"
  ];

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables =
    {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";

      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less -FirSwX";
      MANPAGER = "nvim +Man!";

      NIX_CONFIG_DIR = "${config.xdg.configHome}/nix-darwin";
      ZSH_CONFIG_DIR = "${config.home.sessionVariables.NIX_CONFIG_DIR}/users/${user}/zsh";

      X_SRC_DIR = "$HOME/src";
      Y_SRC_DIR = "$HOME/srcy";

      UNI_DIR = "${config.home.sessionVariables.Y_SRC_DIR}/study";
    }
    // (
      if isDarwin
      then {
        # See: https://github.com/NixOS/nixpkgs/issues/390751
        DISPLAY = "nixpkgs-390751";
      }
      else {}
    );

  home.file = {
  };

  xdg.configFile = {
    "ghostty/config".source = ./ghostty/config;
    "ghostty/shaders/".source = ../../mods/ghostty/shaders;
    "aerospace/".source = ./aerospace;
    "skhd/".source = ./skhd;
    "zellij/".source = ./zellij;
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gpg.enable = !isDarwin;

  services.gpg-agent = {
    enable = isLinux;
    pinentry.package = pkgs.pinentry-tty;

    # cache the keys forever so we don't get asked for a password
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
    dotDir = "${config.xdg.configHome}/zsh";
    initContent = builtins.readFile ./zsh/zshrc;
    profileExtra = lib.concatStringsSep "\n" [
      (builtins.readFile ./zsh/zprofile)
      shScripts
    ];
  };

  programs.nushell = {
    enable = true;
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

  programs.zellij = {
    enable = true;
    # settings = xdg.configFile
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  programs.ghostty = {
    enable = true;
    # settings = xdg files
    installVimSyntax = true;
    package =
      if isDarwin
      then pkgs.ghostty-bin # nix does not support Swift 6 and XCode build env yet.
      else pkgs.ghostty;
  };

  programs.sketchybar = {
    enable = true;
    config = {
      recursive = true;
      source = ./sketchybar;
    };
  };

  programs.aerospace = {
    enable = true;
    # xdg
    # settings =
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

  # Unix and POSIX
  home.shellAliases =
    {
      l = "ls -o";
      la = "ls -a";
      ll = "ls -la";

      rc = "$EDITOR $NIX_CONFIG_DIR";
      zrc = "$EDITOR $ZSH_CONFIG_DIR/zshrc";
      nrc = "$EDITOR $XDG_CONFIG_HOME/nvim/init.lua";

      cd = "z";
      # shScripts
      cdgt = "cd_git_top";

      v = "$EDITOR";
      #shScripts
      vv = "fzf_editor";

      za = "zellij action";
      zz = "zellij attach --create";
      zm = "zellij attach --create main";
      zw = "zellij attach --create work";
      # shScripts
      zu = "zellij_session_layout uni";
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
