{ ... }:

{
  # Pi-hole
  virtualisation.oci-containers.containers."pihole" = {
    autoStart = true;
    image = "pihole/pihole:latest";
    volumes = [
      "/srv/containers/pihole/etc-pihole:/etc/pihole"
      "/srv/containers/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
      "/srv/containers/pihole/secrets:/secrets"
    ];
    ports = [ 
      "53:53/tcp"
      "53:53/udp"
      "8181:80/tcp"
    ];
    environment = {
      WEBPASSWORD_FILE = "/secrets/admin-password";
      DNSMASQ_LISTENING = "all";
    };
  };
}

