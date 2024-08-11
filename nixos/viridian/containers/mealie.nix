{...}: let
  port = "9925";
in {
  virtualisation.oci-containers.containers = {
    mealie = {
      autoStart = true;
      image = "ghcr.io/mealie-recipes/mealie:v1.11.0";
      ports = [
        "${port}:9000"
      ];
      volumes = [
        "/srv/containers/mealie:/app/data/"
      ];
      environment = {
        ALLOW_SIGNUP = "false";
        PUID = "1000";
        PGID = "100";
        TZ = "Australia/Perth";
        MAX_WORKERS = "1";
        WEB_CONCURRENCY = "1";
        BASE_URL = "https://mealie.kanto.dev";
        SECURITY_MAX_LOGIN_ATTEMPTS = "3";
        SECRURITY_USER_LOCKOUT_TIME = "72";
      };
    };
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    mealie = {
      rule = "Host(`mealie.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "crowdsec"
        "geoblock"
      ];
      service = "mealie";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    mealie.loadBalancer.servers = [
      {url = "http://127.0.0.1:${port}";}
    ];
  };
}
