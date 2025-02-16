{...}: let
  port = "8989";
in {
  virtualisation.oci-containers.containers = {
    # PVR for Usenet and BitTorrent users
    sonarr = {
      autoStart = true;
      image = "ghcr.io/hotio/sonarr:release-4.0.13.2932";
      ports = [
        "${port}:8989/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/srv/multimedia:/data:rw"
        # Container data
        "/srv/multimedia/containers/sonarr:/config:rw"
      ];
      environment = {
        PUID = "1000";
        PGID = "100";
      };
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    sonarr = {
      rule = "Host(`sonarr.home.arpa`)";
      entryPoints = [
        "websecure"
      ];
      service = "sonarr";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    sonarr.loadBalancer.servers = [
      {url = "http://127.0.0.1:${port}";}
    ];
  };
}
