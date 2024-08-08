{
  config,
  pkgs,
  inputs,
  ...
}: let
  hostname = config.networking.hostName;
in {
  imports = [
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];

  nixpkgs.overlays = [
    inputs.agenix-rekey.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    agenix-rekey
  ];

  age.rekey = {
    # Pubkey for rekeying
    hostPubkey = ../../${hostname}/ssh_host_ed25519_key.pub;
    # Master identity used for decryption
    masterIdentities = [../users/sajenim/agenix-rekey.pub];
    # Where we store the rekeyed secrets
    storageMode = "local";
    localStorageDir = ./. + "/secrets/rekeyed/${config.networking.hostName}";
  };
}
