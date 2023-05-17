{ ... }:

{
  # Pi-hole
  virtualisation.oci-containers.containers."pihole" = {
    autoStart = true;
    image = "pihole/pihole:latest";
    volumes = [
      "/srv/containers/pihole/etc-pihole:/etc/pihole"
      "/srv/containers/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
    ];
    ports = [ 
      "53:53/tcp"
      "53:53/udp"
      "80:80/tcp"
    ];
    environment = {
      WEBPASSWORD = "";
      DNSMASQ_LISTENING = "all";
    };
  };
}

