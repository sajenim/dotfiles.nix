{ ... }:

{
  imports = [
    ./adguardhome.nix
    ./homarr.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./lidarr.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./recyclarr.nix
    ./sonarr.nix
    ./microbin
  ];
  virtualisation.oci-containers.backend = "docker";
}
