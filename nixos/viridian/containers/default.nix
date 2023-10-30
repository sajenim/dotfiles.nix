{ ... }:

{
  # Import our containers.
  imports = [
    ./homepage
    ./pihole
    ./sonarr
    ./radarr
    ./prowlarr
    ./recyclarr
    ./qbittorrent
    ./minecraft
    ./traefik
  ];

  # Set docker as container implementation.
  virtualisation.oci-containers.backend = "docker";
}
