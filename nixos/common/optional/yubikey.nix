{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Enables files to be encrypted to age identities stored on YubiKeys
    age-plugin-yubikey
    # Setup dm-crypt managed device-mapper mappings.
    cryptsetup
    # Configure our YubiKey via the command line
    yubikey-manager
    # Required for jetbrains password store
    keepass
  ];

  # Manage secret (private) keys.
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };

  # Use our yubikey as a user login or for sudo access
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # Configure services
  services = {
    # Access smart cards using SCard API
    pcscd.enable = true;
  };

  # Enable udev rules for gnupg smart cards
  hardware.gpgSmartcards.enable = true;
}
