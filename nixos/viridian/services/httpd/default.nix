{ ... }:

{
  # Webserver
  services.httpd = {
    enable = true;
    adminAddr = "its.jassy@pm.me";
    virtualHosts."sajenim.dev" = {
      documentRoot = "/var/www/sajenim.dev";
      listen = [{
        ip = "192.168.1.102";
        port = 5624;
        ssl = false;
      }];
    };
  };
}

