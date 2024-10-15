{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/web-apps/immich.nix"
  ];

  age.secrets.immich = {
    rekeyFile = ./secrets.age;
    owner = "immich";
    group = "immich";
  };

  services.immich = {
    enable = true;
    package = pkgs.unstable.immich;
    port = 5489;
    host = "0.0.0.0";
    openFirewall = true;
    mediaLocation = "/var/lib/immich";
    secretsFile = config.age.secrets.immich.path;
    database = {
      enable = true;
      user = "immich";
      name = "immich";
    };
    environment = {
      TZ = "Australia/Perth";
      DB_USERNAME = "immich";
      DB_DATABASE_NAME = "immich";
    };
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    immich = {
      rule = "Host(`photos.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "immich";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    immich.loadBalancer.servers = [
      {url = "http://127.0.0.1:${toString config.services.immich.port}";}
    ];
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/lib/immich";
        user = "immich";
        group = "immich";
      }
      {
        directory = "/var/lib/redis-immich";
        user = "immich";
        group = "immich";
      }
    ];
  };
}
