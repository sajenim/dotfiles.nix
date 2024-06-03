{ ... }:

{
  services.traefik.dynamicConfigOptions.http.services = {
    # sajenim.dev
    httpd.loadBalancer.servers = [
      { url = "http://192.168.1.102:5624"; }
    ];
    forgejo.loadBalancer.servers = [
      { url = "http://192.168.1.102:3131"; }
    ];

    # kanto.dev
    homarr.loadBalancer.servers = [
      { url = "http://192.168.1.102:7575"; }
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
    microbin.loadBalancer.servers = [
      { url = "http://192.168.1.102:8181"; }
    ];
    ender1.loadBalancer.servers = [
      { url = "http://192.168.1.103:80"; }
    ];
  };
}

