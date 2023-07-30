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
      "192.168.1.100:53:53/tcp"   # pihole-FTL (DNS)
      "192.168.1.100:53:53/udp"   # pihole-FTL (DNS)
      "192.168.1.100:8181:80/tcp" # lighttpd   (HTTP)
    ];
    environment = {
      WEBPASSWORD_FILE = "/secrets/admin-password";
      DNSMASQ_LISTENING = "all";
    };
  };
}

