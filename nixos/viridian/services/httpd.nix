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

  services.traefik.dynamicConfigOptions.http.routers = {
    httpd = {
      rule = "Host(`sajenim.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "geoblock"
      ];
      service = "httpd";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    httpd.loadBalancer.servers = [
      { url = "http://127.0.0.1:5624"; }
    ];
  };
}

