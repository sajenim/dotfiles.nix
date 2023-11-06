{ pkgs, ... }:

{
  environment.systemPackages = [
    # Required for hardware acceleration
    pkgs.jellyfin-ffmpeg
  ];

  services = {
    # Volunteer-built media solution that puts you in control of your media
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    # PVR for Usenet and BitTorrent users
    sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/sonarr";
    };
    # Movie collection manager for Usenet and BitTorrent users
    radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/radarr";
    };
    # Music collection manager for Usenet and BitTorrent users
    lidarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/lidarr";
    };
    # Indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps.
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    # Open-source software alternative to µTorrent
    qbittorrent = {
      enable = true;
      openFirewall = true;
      port = 8080;
    };
  };

  # Add our services to relevant groups
  users.groups = {
    media.members = [
      "jellyfin"
      "sonarr"
      "radarr"
      "lidarr"
      "qbittorrent"
    ];
    render.members = [
      "jellyfin"
    ];
  };
}

