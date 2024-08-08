{...}: {
  imports = [
    ./jellyfin.nix
    ./jellyseerr.nix
    ./lidarr.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./recyclarr.nix
    ./sonarr.nix
    ./mealie.nix
    ./microbin
  ];
  virtualisation.oci-containers.backend = "docker";
}
