{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      AllowUsers = [ "sajenim" ];
    };
    ports = [ 62841 ];
    openFirewall = true;
  };
}
