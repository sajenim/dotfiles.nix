{config, ...}: let
  dir = "/var/lib/paperless-ngx";
in {
  age.secrets.paperless-ngx = {
    rekeyFile = ./password.age;
  };

  services.paperless = {
    enable = true;
    port = 28981;
    dataDir = "${dir}";
    mediaDir = "${dir}/media";
    settings = {
      PAPERLESS_ADMIN_USER = "sajenim";
    };
    passwordFile = config.age.secrets.paperless-ngx.path;
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    paperless-ngx = {
      rule = "Host(`docs.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "paperless-ngx";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    paperless-ngx.loadBalancer.servers = [
      {url = "http://127.0.0.1:${toString config.services.paperless.port}";}
    ];
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/lib/paperless-ngx";
        user = "paperless";
        group = "paperless";
      }
      {
        directory = "/var/lib/redis-paperless";
        user = "redis-paperless";
        group = "redis-paperless";
      }
    ];
  };
}
