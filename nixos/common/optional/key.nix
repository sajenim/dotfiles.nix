{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Enables files to be encrypted to age identities stored on YubiKeys
    age-plugin-yubikey
    # Cryptfile
    cryptsetup
    # Yubikey can be used as a smart card for secure encryption
    gnupg
    # Configure your YubiKey via the command line
    yubikey-manager
  ];

  # Use our yubikey as a user login or for sudo access 
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # Enable udev rules for gnupg smart cards
  hardware.gpgSmartcards.enable = true;
}
