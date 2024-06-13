{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      LogLevel = "VERBOSE";
    };
    ports = [ 62841 ];
    openFirewall = true;
  };

  services.rsyslogd = {
    enable = true;
    extraConfig = ''
      if $programname == 'sshd' then /var/log/sshd.log
    '';
  };
}
