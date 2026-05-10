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
  nuFunctions = builtins.readFile ./../../mods/nu/functions.nu;

  initApp = pkgs.writeShellApplication {
    name = "init";
    text = builtins.readFile ./../../mods/init/init.sh;
  };

  vim-macos-ime = pkgs.vimUtils.buildVimPlugin {
    name = "vim-macos-ime";
    src = pkgs.fetchFromGitHub {
      owner = "laishulu";
      repo = "vim-macos-ime";
      rev = "master";
      sha256 = "tQYq/DWb6j+FIAxuA861ct/ym/1y1oROJgk8hqp0rZ0=";
    };
  };
in {
  home.stateVersion = "26.05";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  home.packages = with pkgs;
    [
      ### Lang ###
      nixd
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
      zjstatus
      fastfetch
      giac

      ### GUI App ###
    ]
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
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = with config.home.sessionVariables;
    {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";

      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "nvim +Man!";
      MANPAGER = "nvim +Man!";

      NIX_CONFIG_DIR = "${config.xdg.configHome}/system";
      ZSH_CONFIG_DIR = "${NIX_CONFIG_DIR}/users/${user}/zsh";
      NVIM_CONFIG_DIR = "${NIX_CONFIG_DIR}/users/${user}/nvim";

      X_SRC_DIR = "$HOME/src";
      Y_SRC_DIR = "$HOME/srcy";

      UNI_DIR = "${Y_SRC_DIR}/study";
    }
    // lib.optionals isDarwin {
      # See: https://github.com/NixOS/nixpkgs/issues/390751
      DISPLAY = "nixpkgs-390751";
    };

  home.file = {
  };

  xdg.configFile = {
    "nvim/".source = ./nvim;
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

  programs.starship = {
    enable = true;
    presets = [
      "plain-text-symbols"
    ];
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
    # settings = xdg.configFile
    plugins = with pkgs.vimPlugins;
      [
        # completion
        blink-cmp
        mini-snippets
        # colors
        mini-hipatterns
        alabaster-nvim
        # debugging
        nvim-dap
        nvim-dap-virtual-text
        # lsp
        conform-nvim
        nvim-origami
        easy-dotnet-nvim
        # tree-sitter
        (nvim-treesitter.withPlugins (p:
          with p; [
            c
            cpp
            zig
            go
            lua
            python
            rust
            c_sharp
            fsharp
            haskell
            elixir
            nu
            typst
            objdump
          ]))
        nvim-treesitter-context
        nvim-treesitter-textobjects
        # diagnostics
        trouble-nvim
        # misc
        oil-nvim
        mini-pick
        mini-pairs
        mini-surround
        mini-git
        mini-diff
        which-key-nvim
        vim-slime
      ]
      ++ lib.optionals isDarwin [
        vim-macos-ime
      ];
    extraPackages = with pkgs; [
      tree-sitter
      alejandra
      lua-language-server
      pyright
      tinymist
      roslyn-ls
      fsautocomplete
      fantomas
      zls
      nufmt
    ];
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
      nrc = "${EDITOR} ${NVIM_CONFIG_DIR}";

      men = "tldr";
      human = "tldr_fzf_preview";

      cd = "z";
      cdd = "cd_git_top";

      v = "${EDITOR}";
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
