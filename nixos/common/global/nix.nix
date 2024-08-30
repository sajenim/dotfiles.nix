{
  config,
  inputs,
  lib,
  ...
}: {
  nix = {
    gc = {
      # Automatically run the garbage collector an a specified time.
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # This will add each flake input as a registry
    # To make nix commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      # Additional rights when connecting to the Nix daemon
      trusted-users = [
        "sajenim"
      ];
    };
  };
}
