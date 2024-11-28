{
  inputs,
  config,
  pkgs,
  ...
}: {
  disabledModules = ["services/web-servers/traefik.nix"];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/web-servers/traefik.nix"
    ./middlewares.nix
  ];

  age.secrets.traefik = {
    # Environment variables for porkbun dns challenge
    rekeyFile = ./environment.age;
    owner = "traefik";
    group = "traefik";
  };

  # Ensure our log directory has correct permission to be accesible by crowdsec
  systemd.services.traefik.serviceConfig = {
    User = "traefik";
    Group = "traefik";
    LogsDirectory = "traefik";
    LogsDirectoryMode = "0755";
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

      # Everything that happens to Traefik itself
      log = {
        filePath = "/var/log/traefik/traefik.log";
        level = "ERROR";
      };

      # Who Calls Whom?
      accessLog = {
        filePath = "/var/log/traefik/access.log";
        format = "json";
        filters.statusCodes = [
          "200-299" # log successful http requests
          "400-599" # log failed http requests
        ];
        # collect logs in-memory buffer before writing into log file
        bufferingSize = "0";
        fields.headers = {
          defaultMode = "drop"; # drop all headers per default
          names.User-Agent = "keep"; # log user agent strings
        };
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
          version = "v1.3.5";
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

          # Enable some middlewares on all routers that use this entrypoint
          http.middlewares = [
            "geoblock@file"
            "crowdsec@file"
          ];

          # Requests wildcard SSL certs for our services
          http.tls = {
            certResolver = "lets-encrypt";
            # List of domains in our network
            domains = [
              {
                # DevOps
                main = "sajenim.dev";
                sans = ["*.sajenim.dev"];
              }
              {
                # Keyboards
                main = "sajkbd.io";
                sans = ["*.sajkbd.io"];
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

    # Setup our dashboard
    dynamicConfigOptions.http.routers = {
      traefik-dashboard = {
        rule = "Host(`traefik.home.arpa`)";
        entryPoints = [
          "websecure"
        ];
        service = "api@internal";
      };
    };
  };

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
