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

  shFunctions = builtins.readFile ./../../mods/sh/functions.sh;
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
      fantomas
      zig
      zls
      nodejs
      go

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
      ripgrep
      tree
      flamegraph
      clipboard-jh
      exiftool
      imagemagick
      poppler-utils
      pdfpc
      zjstatus
      fastfetch
      giac

      ### GUI App ###
    ]
    ++ [
      initApp
    ]
    ++ (lib.optionals isDarwin [
      # This is automatically setup on Linux
      gettext
      macism
    ])
    ++ (lib.optionals (isLinux && !isWSL) [
      clang
      valgrind
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
      PAGER = "nvim +Man!";
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
    "ghostty/".source = ./ghostty;
    "aerospace/".source = ./aerospace;
    "skhd/".source = ./skhd;
    "zellij/" = {
      source = ./zellij;
      recursive = true;
    };
    "zellij/plugins/zjstatus.wasm".source = "${pkgs.zjstatus}/bin/zjstatus.wasm";
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
    dotDir = "${config.xdg.configHome}/zsh";
    initContent = builtins.readFile ./zsh/zshrc;
    profileExtra = lib.concatStringsSep "\n" [
      (builtins.readFile ./zsh/zprofile)
      shFunctions
    ];
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
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
  home.shellAliases =
    {
      l = "ls -o";
      la = "ls -a";
      ll = "ls -la";

      rc = "$EDITOR $NIX_CONFIG_DIR";
      zrc = "$EDITOR $ZSH_CONFIG_DIR/zshrc";
      nrc = "$EDITOR $XDG_CONFIG_HOME/nvim/init.lua";

      men = "tldr";
      human = "tldr_fzf_preview";

      cd = "z";
      cdgt = "cd_git_top";

      v = "$EDITOR";
      vv = "fzf_editor";

      zl = "zellij";
      za = "zellij action";
      zz = "zellij attach --create";
      zm = "zellij attach --create Main";
      zw = "zellij attach --create Work";
      zu = "zellij_session_layout Uni uni";
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
