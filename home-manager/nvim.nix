{ inputs, outputs, lib, config, pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    # Language servers
    clang-tools         # C, C++, Objective C/C++, OpenCL, CUDA, and RenderScript
    lua-language-server # Lua
    nil                 # Nix
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    plugins = with pkgs.unstable.vimPlugins; [      
      # Install all grammar packages 
      # nvim-treesitter.withAllGrammars

      # Or specific grammar packages only
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.lua
        p.nix
      ]))

      # Quality of Life Enhancements
      comment-nvim      # Smart and powerful commenting

      # User Interface
      gruvbox-material  # Theme
      dashboard-nvim    # Start screen
      nvim-tree-lua     # File explorer
      lualine-nvim      # Statusline

      # Git Integration
      vim-fugitive      # Call any arbitary git command
      gitsigns-nvim     # Git decorations
      
      # Autocompletion
      nvim-lspconfig    # Collection of configurations for built-in LSP client
      nvim-cmp          # Autocompletion plugin
      cmp-nvim-lsp      # LSP source for nvim-cmp
      cmp_luasnip       # Snippets source for nvim-cmp
      luasnip           # Snippets plugin

      # Misc
      vim-shellcheck    # Static analysis tool for shell scripts

      # Dependencies
      nvim-web-devicons # Provides icons
    ];
  };
}
