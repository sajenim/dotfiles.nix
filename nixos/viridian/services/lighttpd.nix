{ config, ... }:

{
  services.lighttpd = {
    enable = true;
    port = 5624;
    document-root = "/srv/services/websites/sajenim.dev";
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    lighttpd = {
      rule = "Host(`sajenim.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "geoblock"
      ];
      service = "lighttpd";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    lighttpd.loadBalancer.servers = [
      { url = "http://127.0.0.1:${toString config.services.lighttpd.port}"; }
    ];
  };
}

