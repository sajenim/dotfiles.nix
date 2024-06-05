{ config, ... }:

{
  age.secrets.microbin = {
   # Environment variables for microbin
   rekeyFile = ./environment.age;
   owner = "root";
   group = "root";
  };

  virtualisation.oci-containers.containers = {
    # Self-hosted, open-source pastbin
    microbin = {
      autoStart = true;
      image = "danielszabo99/microbin:2.0";
      ports = [
        "8181:8080/tcp" # WebUI
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
      { url = "http://192.168.1.102:8181"; }
    ];
  };
}

