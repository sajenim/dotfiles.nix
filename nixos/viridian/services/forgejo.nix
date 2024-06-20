{ config, ... }:

{
  services.forgejo = {
    enable = true;
    stateDir = "/srv/services/forgejo";
    settings = {
      server = {
        DOMAIN = "git.sajenim.dev";
        ROOT_URL = "https://git.sajenim.dev";
        HTTP_PORT = 3131;
        LANDING_PAGE = "/jasmine";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      log.LEVEL = "Info";
    };
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    forgejo = {
      rule = "Host(`git.sajenim.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "crowdsec"
        "geoblock"
      ];
      service = "forgejo";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    forgejo.loadBalancer.servers = [
      { url = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}"; }
    ];
  };
}

