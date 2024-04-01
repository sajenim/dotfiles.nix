{ config, pkgs, inputs, ... }:
let
  hostname = config.networking.hostName;
in
{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    agenix-rekey
  ];

  age = {
    # Master identity used for decryption
    rekey.masterIdentities = [ ../users/sajenim/agenix-rekey.pub ];
    # Pubkey for rekeying
    rekey.hostPubkey = ../../${hostname}/ssh_host_ed25519_key.pub;
    # Where we store the rekeyed secrets
    rekey.cacheDir = "/var/tmp/agenix-rekey/\"$UID\"";
    # All rekeyed secrets for each host will be collected in a derivation which copies them to the nix store when it is built
    rekey.storageMode = "derivation";
  };
  # Required to persist `/var/tmp/agenix-rekey`
  environment.persistence."/persist".directories = [
    { directory = "/var/tmp/agenix-rekey"; mode = "1777"; }
  ];
  # As user not a trusted-users in our nix.conf
  # we must add age.rekey.cacheDir as a global extra sandbox path
  nix.settings.extra-sandbox-paths = [ "/var/tmp/agenix-rekey" ];
}
