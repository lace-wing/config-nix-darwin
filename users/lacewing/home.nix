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
in {
  home.stateVersion = "25.11";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages =
    [
      pkgs.fd
      pkgs.fzf
      pkgs.gh
      pkgs.htop
      pkgs.jq
      pkgs.ripgrep
      pkgs.tree

      pkgs.zig
      pkgs.nodejs
    ]
    ++ (lib.optionals isDarwin [
      # This is automatically setup on Linux
      pkgs.gettext
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
    "$XDG_DATA_HOME/nvim/mason/bin"
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

      NIX_CONFIG_SRC = "${config.xdg.configHome}/nix-darwin";
      ZSH_CONFIG_SRC = "${config.home.sessionVariables.NIX_CONFIG_SRC}/users/${user}/zsh";
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

      rc = "$EDITOR $ZSH_CONFIG_SRC/zshrc";
      trc = "$EDITOR ~/.tmux.conf";
      nrc = "$EDITOR ~/.config/nvim/init.lua";

      cd = "z";

      v = "nvim";
    }
    // (
      if isDarwin
      then {
        cddc = "cd ~/Documents/";
        cddw = "cd ~/Downloads/";
        cdds = "cd ~/Desktop/";
        cdpc = "cd ~/Pictures/Saved\\ Pictures/";
        cdss = "cd ~/Pictures/Screen\\ Shot/";
        cdas = "cd ~/Library/Application\\ Support/";
        cdic = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs";
      }
      else {}
    );

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gpg.enable = !isDarwin;

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

  programs.direnv = {
    enable = true;

    config = {
      whitelist = {
        exact = ["$HOME/.envrc"];
      };
    };
  };

  programs.git = {
    enable = true;
  };

  programs.go = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  programs.nushell = {
    enable = true;
  };

  services.gpg-agent = {
    enable = isLinux;
    pinentry.package = pkgs.pinentry-tty;

    # cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = lib.mkIf (isLinux && !isWSL) {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}
