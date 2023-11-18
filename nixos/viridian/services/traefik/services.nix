{ ... }:

{
  services.traefik.dynamicConfigOptions.http.services = {
    httpd.loadBalancer.servers = [
      { url = "http://192.168.1.102:5624"; }
    ];
    microbin.loadBalancer.servers = [
      { url = "http://192.168.1.102:8181"; }
    ];
    homarr.loadBalancer.servers = [
      { url = "http://192.168.1.102:7575"; }
    ];
    home-assistant.loadBalancer.servers = [
      { url = "http://192.168.1.102:8123"; }
    ];
    adguard-home.loadBalancer.servers = [
      { url = "http://192.168.1.102:3000"; }
    ];
    minecraft.loadBalancer.servers = [
      { url = "http://192.168.1.102:25565"; }
    ];
    jellyfin.loadBalancer.servers = [
      { url = "http://192.168.1.102:8096"; }
    ];
    sonarr.loadBalancer.servers = [
      { url = "http://192.168.1.102:8989"; }
    ];
    radarr.loadBalancer.servers = [
      { url = "http://192.168.1.102:7878"; }
    ];
    lidarr.loadBalancer.servers = [
      { url = "http://192.168.1.102:8686"; }
    ];
    prowlarr.loadBalancer.servers = [
      { url = "http://192.168.1.102:9696"; }
    ];
    qbittorrent.loadBalancer.servers = [
      { url = "http://192.168.1.102:8080"; }
    ];
    jellyseerr.loadBalancer.servers = [
      { url = "http://192.168.1.102:5055"; }
    ];
  };
}

