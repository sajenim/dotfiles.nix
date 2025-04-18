{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    # Toolchain
    pkgs.gcc
    pkgs.python313Full # Note: keep this in sync with school

    # Install our nixvim configuration for neovim.
    inputs.nixvim.packages.${pkgs.system}.default
  ];
}
