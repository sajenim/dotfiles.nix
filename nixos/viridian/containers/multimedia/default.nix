{ ... }:

{
  virtualisation.oci-containers.containers = {
    # Volunteer-built media solution that puts you in control of your media
    jellyfin = {
      autoStart = true;
      image = "jellyfin/jellyfin:10.8.12";
      ports = [
        "8096:8096/tcp" # HTTP traffic
        "8920:8920/tcp" # HTTPS traffic
        # "1900:1900/udp" # Service auto-discovery
        "7359:7359/udp" # Client auto-discovery
      ];
      volumes = [
        # Media library
        "/mnt/data/htpc/media:/media:ro"
        # Container data
        "/var/lib/jellyfin/config:/config:rw"
        "/var/lib/jellyfin/cache:/cache:rw"
      ];
      extraOptions = [
        "--group-add=303"
        "--device=/dev/dri/renderD128:/dev/dri/renderD128"
        "--network=media-stack"
      ];
    };
    # PVR for Usenet and BitTorrent users
    sonarr = {
      autoStart = true;
      image = "ghcr.io/hotio/sonarr:nightly-4.0.0.710";
      ports = [
        "8989:8989/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/mnt/data/htpc:/data:rw"
        # Container data
        "/var/lib/sonarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
    # Movie collection manager for Usenet and BitTorrent users
    radarr = {
      autoStart = true;
      image = "ghcr.io/hotio/radarr:nightly-5.1.3.8237";
      ports = [
        "7878:7878/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/mnt/data/htpc:/data:rw"
        # Container data
        "/var/lib/radarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
    # # Music collection manager for Usenet and BitTorrent users
    lidarr = {
      autoStart = true;
      image = "ghcr.io/hotio/lidarr:nightly-2.0.2.3782";
      ports = [
        "8686:8686/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/mnt/data/htpc:/data:rw"
        # Container data
        "/var/lib/lidarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
    # Indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps.
    prowlarr = {
      autoStart = true;
      image = "ghcr.io/hotio/prowlarr:nightly-1.10.3.4070";
      ports = [
        "9696:9696/tcp" # WebUI
      ];
      volumes = [
        # Container data
        "/var/lib/prowlarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
    # Automatically synchronize recommended settings from the TRaSH guides to your Sonarr/Radarr instances
    recyclarr = {
      autoStart = true;
      image = "ghcr.io/hotio/recyclarr:6.0";
      volumes = [
        "/var/lib/recyclarr:/config"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
    # # Open-source software alternative to µTorrent
    qbittorrent = {
      autoStart = true;
      image = "ghcr.io/hotio/qbittorrent:release-4.6.0";
      ports = [
        "8080:8080/tcp"   # WebUI
        "32372:32372/tcp" # Transport protocol
      ];
      volumes = [
        # Seedbox
        "/mnt/data/htpc/torrents:/data/torrents:rw"
        "/var/lib/qbittorrent:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
    jellyseerr = {
      autoStart = true;
      image = "ghcr.io/hotio/jellyseerr";
      ports = [
        "5055:5055/tcp" # WebUI
      ];
      volumes = [
        "/var/lib/jellyseerr:/config"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
  virtualisation.oci-containers.backend = "docker";
}

