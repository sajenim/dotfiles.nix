{ ... }:

{
  services.httpd = {
    enable = true;
    virtualHosts."sajenim.dev" = {
      documentRoot = "/srv/services/httpd/sajenim.dev";
      listen = [{
        ip = "192.168.1.102";
        port = 5624;
      }];
      adminAddr = "its.jassy@pm.me";
    };
  };
}

