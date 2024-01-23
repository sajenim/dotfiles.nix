{ ... }:

{
  virtualisation.oci-containers.containers = {
    # Automatically synchronize recommended settings from the TRaSH guides to your Sonarr/Radarr instances
    recyclarr = {
      autoStart = true;
      image = "ghcr.io/hotio/recyclarr:6.0";
      volumes = [
        "/srv/containers/recyclarr:/config"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
}
