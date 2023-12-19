{ inputs, config, pkgs, ... }:

{
  disabledModules = [ "services/web-servers/traefik.nix" ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/web-servers/traefik.nix"
    ./routers.nix
    ./middlewares.nix
    ./services.nix
  ];

  age.secrets.traefik = {
    # Environment variables for cloudflare dns challenge
    file = inputs.self + /secrets/traefik.age;
    owner = "traefik";
    group = "traefik";
  };

  systemd.services.traefik.serviceConfig = {
    User = "traefik";
    Group = "traefik";
    LogsDirectory = "traefik";
    LogsDirectoryMode = "0750";
  };

  # Reverse proxy and load balancer for HTTP and TCP-based applications
  services.traefik = {
    enable = true;
    package = pkgs.unstable.traefik;
    dataDir = "/var/lib/traefik";
    environmentFiles = [
      config.age.secrets.traefik.path
    ];

    # The startup configuration
    staticConfigOptions = {
      api = {
        # Enable the API in secure mode
        insecure = false;
        # Enable the dashboard
        dashboard = true;
      };

      log = {
        filePath = "/var/log/traefik/traefik.log";
        level = "INFO";
      };
      accessLog = {
        filePath = "/var/log/traefik/access.log";
        format = "json";
      };

      # Install plugins
      experimental.plugins = {
        geoblock = {
          moduleName = "github.com/PascalMinder/geoblock";
          version = "v0.2.7";
        };
      };

      # Network entry points into Traefik
      entryPoints = {
        # Hypertext Transfer Protocol
        web = {
          address = ":80";
          # Redirect all incoming HTTP requests to HTTPS
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        # Hypertext Transfer Protocol Secure
        websecure = {
          address = ":443";
          # Trust cloudflares forwarded header information
          forwardedHeaders.trustedIPs = [
            "173.245.48.0/20"
            "103.21.244.0/22"
            "103.22.200.0/22"
            "103.31.4.0/22"
            "141.101.64.0/18"
            "108.162.192.0/18"
            "190.93.240.0/20"
            "188.114.96.0/20"
            "197.234.240.0/22"
            "198.41.128.0/17"
            "162.158.0.0/15"
            "172.64.0.0/13"
            "131.0.72.0/22"
            "104.16.0.0/13"
            "104.24.0.0/14"
          ];
          # Requests wildcard SSL certs for our services
          http.tls = {
            certResolver = "lets-encrypt";
            # List of domains in our network
            domains = [
              # Internal services
              { main = "kanto.dev";
                sans = [ "*.kanto.dev" ];
              }
              # Public services
              { main = "sajenim.dev";
                sans = [ "*.sajenim.dev" ];
              }
            ];
          };
        };
      };

      # Retrieve certificates from an ACME server
      certificatesResolvers = {
        # Setup a lets-encrypt environment
        lets-encrypt.acme = {
          # Email address used for registration
          email = "its.jassy@pm.me";
          # File or key used for certificate storage
          storage = "/var/lib/traefik/acme.json";
          # Certificate authority server to use
          caServer = "https://acme-v02.api.letsencrypt.org/directory";
          # Use a DNS-01 ACME challenge
          dnsChallenge = {
            provider = "cloudflare";
            resolvers = [
              "1.1.1.1:53"
              "8.8.8.8:53"
            ];
          };
        };
      };
      # Disables SSL certificate verification between our traefik instance and our backend
      serversTransport = {
        insecureSkipVerify = true;
      };
    };
  };
}

