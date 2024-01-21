{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Configure your YubiKey via the command line
    yubikey-manager
    # Enables files to be encrypted to age identities stored on YubiKeys
    age-plugin-yubikey
  ];

  # GPG and SSH support
  services.udev.packages = [ pkgs.yubikey-personalization ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Use our yubikey as a user login or for sudo access 
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}
