{ inputs, ... }:

{
  # Install our nixvim configuration for neovim.
  home.packages = [ inputs.nixvim-config.packages.x86_64-linux.default ];
}

