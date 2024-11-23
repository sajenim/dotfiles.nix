{...}: {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      LogLevel = "VERBOSE";
    };
    ports = [22];
    openFirewall = true;
  };
}
