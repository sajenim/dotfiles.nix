{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim-nightly;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Required for nvim-treesitter
      gcc
      # Required for telescope.nvim
      fd
      ripgrep
      # Required for markdown-preview.nvim
      nodejs
      yarn
      # Language server packages
      nil
      haskell-language-server
      lua-language-server
    ];
  };

  home.persistence."/persist/home/sajenim".directories = [ ".local/share/nvim" ];

  xdg.configFile.nvim = { source = ./config; recursive = true; };
}
