{...}: {
  virtualisation.oci-containers.containers = {
    # Automatically synchronize recommended settings from the TRaSH guides to your Sonarr/Radarr instances
    recyclarr = {
      autoStart = true;
      image = "ghcr.io/recyclarr/recyclarr:6.0.2";
      volumes = [
        "/srv/containers/recyclarr:/config"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
      user = "1000:100";
    };
  };
}
