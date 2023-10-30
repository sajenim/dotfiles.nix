{ inputs, outputs, lib, config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim-nightly;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Misc
      lazygit
      # Required for nvim-treesitter
      gcc
      # Required for telescope.nvim
      fd
      ripgrep
      # Language server packages
      nil
      haskell-language-server
      lua-language-server
    ];
  };

  xdg.configFile.nvim = { source = ./config; recursive = true; };
}
