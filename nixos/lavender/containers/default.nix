{ ... }:

{
  imports = [
    # Dashboard
    ./homepage

    # Website
    ./nginx

    # Dns blackhole
    ./pihole

    # Multimedia
    ./plex
    ./sonarr
    ./radarr
    ./prowlarr
    ./recyclarr

    # Documents & Files
    ./qbittorrent

    # Game servers
    ./minecraft

    # Reverse proxy
    ./traefik
  ];
}
