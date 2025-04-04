{
  pkgs,
  inputs,
  ...
}: {
  # This module is for the ReMarkable tablet, which is a Linux-based e-reader
  home.packages = [
    # Allows access to the ReMarkable Cloud API
    pkgs.unstable.rmapi
    # Converts ReMarkable files to PDF
    inputs.remarks.packages.${pkgs.system}.default
  ];
}
