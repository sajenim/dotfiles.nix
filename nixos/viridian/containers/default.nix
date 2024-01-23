{ ... }:

{
  imports = [
    ./adguardhome.nix
    ./homarr.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./minecraft.nix
    ./lidarr.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./recyclarr.nix
    ./sonarr.nix
  ];
  virtualisation.oci-containers.backend = "docker";
}
