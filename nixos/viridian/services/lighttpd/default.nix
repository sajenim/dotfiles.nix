{config, ...}: {
  services.lighttpd = {
    enable = true;
    port = 5624;
    document-root = "/srv/www/sajenim.dev";
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    lighttpd = {
      rule = "Host(`sajenim.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "crowdsec"
        "geoblock"
      ];
      service = "lighttpd";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    lighttpd.loadBalancer.servers = [
      {url = "http://127.0.0.1:${toString config.services.lighttpd.port}";}
    ];
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/srv/www";
        user = "lighttpd";
        group = "lighttpd";
      }
    ];
  };
}
