{ ... }:

{
  services.httpd = {
    enable = true;
    virtualHosts."sajenim.dev" = {
      documentRoot = "/var/www/sajenim.dev";
      listen = [{
        ip = "192.168.1.102";
        port = 5624;
      }];
    };
  };
  environment.persistence."/persist" = {
    directories = [
      "/var/www/sajenim.dev"
    ];
    hideMounts = true;
  };
}
