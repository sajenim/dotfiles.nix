{ ... }:

{
  # Privacy protection center
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      # Web interface IP address to listen on.
      bind_port = 3000;
      # Web interface IP port to listen on.
      bind_host = "0.0.0.0";
      # Custom DNS responses
      dns.rewrites = [
        { # LAN self-host domain
          domain = "kanto.dev";
          answer = "192.168.1.102";
        }
        { # Wildcard subdomains
          domain = "*.kanto.dev";
          answer = "kanto.dev";
        }
      ];
    };
    mutableSettings = true;
  };
}

