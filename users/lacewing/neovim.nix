{
  lib,
  config,
  pkgs,
  user,
  isDarwin,
  ...
}: let
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
  programs.neovim = {
    enable = true;

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
            eex
            heex
            nu
            typst
            objdump
            html
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
      nixd
      elixir-ls
      zls
      nufmt
    ];
  };

  xdg.configFile = {
    "nvim/".source = ./nvim;
  };

  home.sessionVariables = with config.home.sessionVariables; {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    NVIM_CONFIG_DIR = "${NIX_CONFIG_DIR}/users/${user}/nvim";
  };

  home.shellAliases = with config.home.sessionVariables; {
    nrc = "${EDITOR} ${NVIM_CONFIG_DIR}";
  };
}
