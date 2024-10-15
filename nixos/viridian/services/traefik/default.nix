{
  inputs,
  config,
  pkgs,
  ...
}: {
  disabledModules = ["services/web-servers/traefik.nix"];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/web-servers/traefik.nix"
    ./routers.nix
    ./middlewares.nix
    ./services.nix
  ];

  age.secrets.traefik = {
    # Environment variables for porkbun dns challenge
    rekeyFile = ./environment.age;
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
        level = "ERROR";
      };
      accessLog = {
        filePath = "/var/log/traefik/access.log";
        format = "json";
      };

      # Install plugins
      experimental.plugins = {
        # Block or allow requests based on their country of origin.
        geoblock = {
          moduleName = "github.com/PascalMinder/geoblock";
          version = "v0.2.7";
        };

        # Authorize or block requests from IPs based on there reputation and behaviour.
        bouncer = {
          moduleName = "github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin";
          version = "v1.3.2";
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
          # Requests wildcard SSL certs for our services
          http.tls = {
            certResolver = "lets-encrypt";
            # List of domains in our network
            domains = [
              # Internal services
              {
                main = "kanto.dev";
                sans = ["*.kanto.dev"];
              }
              # Public services
              {
                main = "sajenim.dev";
                sans = ["*.sajenim.dev"];
              }
              # Keyboards
              {
                main = "sajkbd.io";
                sans = ["*.sajkbd.io"];
              }
            ];
          };
        };
        # Used to expose metrics
        metrics = {
          address = ":8082";
        };
      };

      # Provide metrics for the prometheus backend
      metrics = {
        prometheus = {
          entryPoint = "metrics";
          buckets = ["0.1" "0.3" "1.2" "5.0"];
          addEntryPointsLabels = true;
          addRoutersLabels = true;
          addServicesLabels = true;
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
            provider = "porkbun";
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

  # Scrape our traefik metrics
  services.prometheus.scrapeConfigs = [
    {
      job_name = "traefik";
      static_configs = [
        {
          targets = ["127.0.0.1:8082"];
        }
      ];
    }
  ];

  # Persist our traefik data & logs
  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/lib/traefik";
        user = "traefik";
        group = "traefik";
      }
      {
        directory = "/var/log/traefik";
        user = "traefik";
        group = "traefik";
      }
      {
        directory = "/plugins-storage";
        user = "traefik";
        group = "traefik";
      }
    ];
    hideMounts = true;
  };
}
