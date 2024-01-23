{ ... }:

{
  virtualisation.oci-containers.containers = {
    adguardhome = {
      autoStart = true;
      image = "adguard/adguardhome";
      ports = [
        "53:53"     # Plain DNS
        "3000:3000" # WEBGUI
      ];
      volumes = [
        "/srv/containers/adguardhome/work:/opt/adguardhome/work"
        "/srv/containers/adguardhome/conf:/opt/adguardhome/conf"
      ];
      extraOptions = [
        "--network=host"
      ];
    };
  };
}
