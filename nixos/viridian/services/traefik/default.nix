{ inputs, config, pkgs, ... }:

{
  disabledModules = [ "services/web-servers/traefik.nix" ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/web-servers/traefik.nix"
    ./media-stack.nix
  ];

  age.secrets.traefik = {
    # Environment variables for cloudflare dns challenge
    file = inputs.self + /secrets/traefik.age;
    owner = "traefik";
    group = "traefik";
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

    # Fully dynamic routing configuration
    dynamicConfigOptions = {
      # Connect requests to services
      http = {
        routers = {
          # Central control system
          home-assistant = {
            rule = "Host(`kanto.dev`)";
            entryPoints = [ 
              "websecure"
            ];
            middlewares = [ 
              "internal"
            ];
            service = "home-assistant";
          };

          # Traefik dashboard
          traefik-dashboard = {
            rule = "Host(`traefik.kanto.dev`)";
            entryPoints = [
              "websecure"
            ];
            middlewares = [
              "internal"
            ];
            service = "api@internal";
          };

          # Adguard Home
          adguard-home = {
            rule = "Host(`adguard.kanto.dev`)";
            entryPoints = [
              "websecure"
            ];
            middlewares = [
              "internal"
            ];
            service = "adguard-home";
          };

          # Minecraft
          minecraft = {
            rule = "Host(`mc.kanto.dev`)";
            entryPoints = [
              "websecure"
            ];
            middlewares = [
              "internal"
            ];
            service = "minecraft";
          };
        };

        # Tweaking the requests
        middlewares = {
          # Restrict access to internal networks
          internal.ipwhitelist.sourcerange = [
            "127.0.0.1/32"    # localhost
            "192.168.1.1/24"  # lan
          ];
        };

        # How to reach the actual services
        services = {
          home-assistant.loadBalancer.servers = [
            { url = "http://192.168.1.102:8123"; }
          ];
          adguard-home.loadBalancer.servers = [
            { url = "http://192.168.1.102:3000"; }
          ];
          minecraft.loadBalancer.servers = [
            { url = "http://192.168.1.102:25565"; }
          ];
        };
      };        
    };
  };
}

