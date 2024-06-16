{ config, ... }:
let
  port = "8181";
in
{
  age.secrets.microbin = {
   # Environment variables for microbin
   rekeyFile = ./environment.age;
   owner = "sajenim";
   group = "users";
  };

  virtualisation.oci-containers.containers = {
    # Self-hosted, open-source pastbin
    microbin = {
      autoStart = true;
      image = "danielszabo99/microbin:2.0";
      ports = [
        "${port}:8080/tcp" # WebUI
      ];
      volumes = [
        # Container data
        "/srv/containers/microbin:/app/microbin_data:rw"
      ];
      environmentFiles = [
        config.age.secrets.microbin.path
      ];
    };
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    microbin = {
      rule = "Host(`bin.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "microbin";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    microbin.loadBalancer.servers = [
      { url = "http://127.0.0.1:${port}"; }
    ];
  };
}

