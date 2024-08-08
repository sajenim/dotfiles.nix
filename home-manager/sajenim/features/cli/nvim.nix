{ inputs, pkgs, ... }:

{
  # Install our nixvim configuration for neovim.
  home.packages = [ inputs.nixvim.packages.${pkgs.system}.default ];
}

