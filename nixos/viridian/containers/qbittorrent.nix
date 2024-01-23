{ ... }:

{
  virtualisation.oci-containers.containers = {
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
        "/srv/multimedia/torrents:/data/torrents:rw"
        "/srv/containers/qbittorrent:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
}
