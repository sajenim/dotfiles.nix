{ config, pkgs, ... }:
let
  hostname = config.networking.hostName;
in
{
  environment.systemPackages = with pkgs; [
    agenix-rekey
  ];

  age = {
    # Master identity used for decryption
    rekey.masterIdentities = [ ../users/sajenim/agenix-rekey.pub ];
    # Pubkey for rekeying
    rekey.hostPubkey = ../../${hostname}/ssh_host_ed25519_key.pub;
    # As user not a trusted-users in our nix.conf
    # we must add age.rekey.cacheDir as a global extra sandbox path
    rekey.cacheDir = "/var/tmp/agenix-rekey/\"$UID\"";
  };

  # Required to persist `/var/tmp/agenix-rekey`
  environment.persistence."/persist".directories = [
    { directory = "/var/tmp/agenix-rekey"; mode = "1777"; }
  ];
}
